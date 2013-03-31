require 'guard/guard'
require 'guard/handlebars'

guard 'rack' do
  watch('Gemfile.lock')
  watch('config.ru')
  watch('app/app.rb')
end

# TODO: Having the views in a folder below 'coffee' doesn't feel perfect, but will have to be OK for now.
guard 'handlebars', :input => 'app/coffee/views', :output => 'app/coffee/views' do
  watch(%r{app/coffee/views/(.+\.handlebars)})
end
