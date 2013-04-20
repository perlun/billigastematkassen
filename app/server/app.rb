#!/usr/bin/env jruby

require 'coffee_script'
require 'json'
require 'rack/handler/mizuno'
require 'redis'
require 'sinatra/base'
require 'sprockets'
require 'unicode_utils/downcase'
require_relative 'api'

class App < Sinatra::Base
  set :server, 'mizuno'

  set :port, 8082
  set :root, Dir.pwd
  set :public_folder, settings.root + '/htdocs'
  set :assets, Sprockets::Environment.new

  settings.assets.append_path 'htdocs'
  settings.assets.append_path 'app/client'

  enable :logging
  disable :show_exceptions, :dump_errors, :raise_errors

  get '/' do
    send_file settings.public_folder + '/index.html'
  end

  get '/js/:file.js' do
    content_type 'application/javascript'
    settings.assets["#{params[:file]}.js"]
  end

  error do
    puts "Exception thrown: " + env['sinatra.error'].to_s
    puts "Stack trace: "
    puts env['sinatra.error'].backtrace.first(10)
    500
  end
end
