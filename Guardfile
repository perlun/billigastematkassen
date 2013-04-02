require 'guard/guard'
require 'guard/ember-handlebars'

guard 'rack' do
  watch('Gemfile.lock')
  watch('config.ru')
  watch('app/server/app.rb')
end

# TODO: Having the views in a folder below 'coffee' doesn't feel perfect, but will have to be OK for now.
guard 'ember_handlebars',
    :input => 'app/client/views',
    :output => 'app/client/views',
    :remove_prefix => 'app/client/' do
  watch(%r{app/client/views/(.+\.handlebars)})
end
