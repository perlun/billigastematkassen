#\ -p 8082

require 'bundler/setup'
require './app/server/app.rb'

app = App.new
rackup = Rack::Builder.app do
  run app
end

run rackup
