require 'guard/guard'

guard 'rack' do
  watch('Gemfile.lock')
  watch('config.ru')
  watch(%r{^(config|lib|app)/.*})
end

guard 'coffeescript',
  :input => 'htdocs/coffee',
  :output => 'htdocs/js',
  :bare => true
