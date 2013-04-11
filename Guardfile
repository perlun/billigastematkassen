require 'guard/guard'
require 'guard/underscore-templates'

guard 'rack' do
  watch('Gemfile.lock')
  watch('config.ru')
  watch('app/server/app.rb')
end

guard 'underscore_templates',
    :input => 'app/client/views',
    :output => 'app/client/views',
    :remove_prefix => 'app/client/' do
  watch(%r{^app/client/views/(.+\.tpl)$})
end
