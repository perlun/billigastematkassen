require 'bson'
require 'json'
require 'redis'
require 'unicode_utils/downcase'

class App < Sinatra::Base
  def initialize
    super

    @redis = Redis.new
  end

  get '/api/products' do get_products end
  post '/api/product' do post_product(request) end

private

  def get_products
    products = @redis.hgetall('products')
    products = products.map do |key, value|
      result = parse_json(value)
      result[:objectId] = key
      result
    end

    products.each do |product|
      add_extra_data(product)
    end

    products = products.sort_by do |product|
      key = UnicodeUtils.downcase(product[:name] + '_' + product[:brand])
    end

    return_json products.to_json
  end

  def post_product(request)
    # The code below is written to work with dhtmlxDataProcessor, http://docs.dhtmlx.com/doku.php?id=dhtmlxgrid:dataprocessor
    mode = request.params['!nativeeditor_status']
    source_id = request.params['gr_id']

    if mode == 'inserted'
      # We don't actually do the insert here, but wait until we have some data (since we know that we always populate rows with
      # empty columns first)
      target_id = BSON::ObjectId.new
      action = 'insert'
    elsif mode == 'deleted'
      target_id = source_id
      @redis.hdel('products', target_id)
      action = 'delete'
    elsif mode == 'updated'
      update_product(source_id, request.params)
      target_id = source_id
      action = 'update'
    end

    return_xml "
      <?xml version='1.0' encoding='utf-8'?>
      <data>
        <action type='#{action}' sid='#{source_id}' tid='#{target_id}'/>
      </data>"
  end

  def update_product(source_id, params)
    product_data = @redis.hget('products', source_id)
    product = (parse_json(product_data) if product_data) || {}

    %w(
      name
      qty
      unitOfMeasure
      brand
      manufacturer
      productGroup
     ).each do |field|
      product[field.to_sym] = params[field]
    end

    product[:prices] ||= {}
    %w(
      axet
      citymarket
      minimani
      prisma
    ).each do |price_field|
      price = params['prices.' + price_field]
      price = price.sub(',', '.')   # Handle comma as decimal separator

      if price.empty?
        price = nil
      else
        price = price.to_f
      end

      product[:prices][price_field.to_sym] = price
    end

    target_id = source_id
    @redis.hset('products', target_id, product.to_json)
  end

  def add_extra_data(product)
    return unless product[:name]

    slug = "#{sanitize_name product[:name]}_#{localize product[:qty]}_#{product[:unitOfMeasure]}_#{sanitize_name product[:brand]}"
    file_name = "img/items/#{slug}.jpg"
    product.delete :imageUrl

    if File.exist?("#{settings.public_folder}/#{file_name}")
      product[:imageUrl] = '/' + file_name
    else
      puts "#{file_name} image file not found"
    end

    product[:slug] = slug
  end

  def parse_json(str)
    JSON.parse(str, { :symbolize_names => true })
  end

  def sanitize_name(str)
    str = UnicodeUtils.downcase(str)
    str.gsub(' ', '_')
  end

  def localize(str)
    str.to_s.gsub('.', ',')
  end

  def return_json(json)
    [
      200,
      {
        'Content-Type' => 'application/json'
      },
      [
        json
      ]
    ]
  end

  def return_xml(xml)
    [
      200,
      {
        'Content-Type' => 'text/xml'
      },
      [
        xml.strip
      ]
    ]
  end
end
