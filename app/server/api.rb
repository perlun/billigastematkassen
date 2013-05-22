# coding: utf-8

require 'bson'
require 'json'
require 'redis'
require 'unicode_utils/downcase'

class App < Sinatra::Base
  get '/api/basket' do
    return_json get_basket(request, env)
  end

  put '/api/basket' do
    save_basket(request, env)
    return_json '"Success"'
  end

  get '/api/productGroups' do
    return_json get_product_groups.to_json
  end
  
  get '/api/products' do
    return_json get_products.to_json
  end

  post '/api/product/new' do
    return_json create_product(request).to_json
  end

  put '/api/product/:item_id' do
    update_product(params[:item_id], request)
    return_json '"Success"'
  end

  delete '/api/product/:item_id' do
    delete_product params[:item_id]
    return_json({
      :result => 'Success'
    }.to_json)
  end

private

  def get_product_groups
    product_groups = JSON.parse(IO.read 'db/product_groups.json')
    product_groups.each do |productGroup|
      productGroup['slug'] = slugify productGroup['name']
    end
  end

  def get_products
    redis = Redis.new
    products = redis.hgetall('products')

    products = products.map do |key, value|
      product = parse_json(value)
      product[:objectId] = key
      product[:prices] ||= {}
      product[:brand] ||= ''
      product
    end

    products.each do |product|
      add_extra_product_data(product)
    end

    products = products.sort_by do |product|
      key = UnicodeUtils.downcase(product[:name] + '_' + product[:brand])
    end

     products
  end

  def create_product(request)
    request.body.rewind
    product = parse_json request.body.read

    object_id = BSON::ObjectId.new.to_s

    redis = Redis.new
    redis.hset('products', object_id, product.to_json)

    return_json(
      'objectId' => object_id
    )
  end

  def delete_product(product_id)
    redis = Redis.new
    redis.hdel('products', product_id)
  end

  def update_product(product_id, request)
    request.body.rewind
    product = parse_json request.body.read

    product[:prices] ||= {}
    %w(saleSolf citymarket minimani prisma).each do |price_field|
      price = product[:prices][price_field.to_sym]
      price = (price || '').sub(',', '.')   # Handle comma as decimal separator

      if price.empty?
        price = nil
      else
        price = price.to_f
      end

      product[:prices][price_field.to_sym] = price
    end

    redis = Redis.new
    redis.hset('products', product_id, product.to_json)
  end

  def add_extra_product_data(product)
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

  def get_basket(request, env)
    redis = Redis.new

    redis.hget('baskets', env['REMOTE_ADDR']) || '{}'
  end

  def save_basket(request, env)
    redis = Redis.new

    request.body.rewind
    redis.hset('baskets', env['REMOTE_ADDR'], request.body.read)
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

  def slugify(str)
    str = str.gsub(/ /, '_')
    str = str.gsub(/&/, 'och')
    str = str.tr('åäö', 'aao')
    str.downcase
  end
end
