$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'api'))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'app'))
$LOAD_PATH.unshift(File.dirname(__FILE__))

require 'boot'

Bundler.require :default, ENV['RACK_ENV']
preload = [
  # './config/initializers/*.rb',
  '../../lib/**/*.rb',
  '../../api/*.rb',
  '../../app/**/*.rb'
]

preload.each do |dir|
  Dir[File.expand_path(dir, __FILE__)].each { |f| require f }
end

# Dir[File.expand_path('../../api/*.rb', __FILE__)].each do |f|
#   require f
# end

require 'api'
require 'haiku_app'
