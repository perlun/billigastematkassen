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
    [
      200, 
      {
        'Content-Type' => 'application/json'
      }, [ IO.read(File.dirname(__FILE__) + '/prices.json') ] 
    ]
  end

  post '/api/prices' do
    IO.write(File.dirname(__FILE__) + '/prices.json', request.body.read)

    { 'result' => 'Success' }.to_json
  end
end
