#!/usr/bin/env jruby

require 'rack/handler/mizuno'
require 'sinatra/base'
require 'json'

class App < Sinatra::Base
  set :server, 'mizuno'

  set :port, 8082
  set :root, Pathname.new(settings.root + '/..').cleanpath.to_s
  set :public_folder, settings.root + '/htdocs'

  enable :logging

  get '/' do
    send_file settings.public_folder + '/index.html'
  end

  get '/api/prices' do
    prices = JSON.parse(IO.read('db/prices.json'), 
      { :symbolize_names => true }
    )
    prices.each do |price|
      next unless price[:name]

      file_name = "img/items/#{price[:name].downcase}_#{localize price[:qty]}_#{price[:unitOfMeasure]}_#{price[:brand]}.jpg"
      price['imageUrl'] = '/' + file_name if File.exist?("#{settings.public_folder}/#{file_name}")
    end

    [
      200, 
      {
        'Content-Type' => 'application/json'
      }, [ prices.to_json ] 
    ]
  end

  post '/api/prices' do
    IO.write('db/prices.json', request.body.read)

    { 'result' => 'Success' }.to_json
  end

private

  def localize(str)
    str.gsub('.', ',')    
  end
end
