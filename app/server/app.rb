#!/usr/bin/env jruby

require 'coffee_script'
require 'json'
require 'rack/handler/mizuno'
require 'redis'
require 'sinatra/base'
require 'sprockets'
require 'unicode_utils/downcase'

class App < Sinatra::Base
  set :server, 'mizuno'

  set :port, 8082
  set :root, Dir.pwd
  set :public_folder, settings.root + '/htdocs'
  set :assets, Sprockets::Environment.new

  settings.assets.append_path 'htdocs'
  settings.assets.append_path 'app/client'

  enable :logging

  get '/' do
    send_file settings.public_folder + '/index.html'
  end

  get '/js/:file.js' do
    content_type 'application/javascript'
    settings.assets["#{params[:file]}.js"]
  end  

  get '/api/products' do
    redis = Redis.new
    products = redis.hgetall('products')
    products = products.map do |key, value|
      result = JSON.parse(value, { :symbolize_names => true })
      result[:objectId] = key
      result
    end

    products.each do |product|
      next unless product[:name]

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

    [
      200, 
      {
        'Content-Type' => 'application/json'
      }, [ products.to_json ] 
    ]
  end

  post '/api/products' do
    IO.write('db/products.json', request.body.read)

    { 'result' => 'Success' }.to_json
  end

private

  def sanitize_name(str)
    str = UnicodeUtils.downcase(str)
    str.gsub(' ', '_')
  end

  def localize(str)
    str.to_s.gsub('.', ',')    
  end
end
