$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'app'))
$LOAD_PATH.unshift(File.dirname(__FILE__))

require 'boot'

Bundler.require :default, ENV['RACK_ENV']

module HaikuBot
  class << self; attr_accessor :capture_exceptions; end
  include ActiveSupport::Configurable
end

Haiku.capture_exceptions = true if Haiku.capture_exceptions.nil?

Haiku.configure do |config|
  config.root = File.expand_path(File.join(File.dirname(__FILE__), '..'))
  config.data_dir = File.join(config.root, 'data')
  config.env = ActiveSupport::StringInquirer.new(ENV['RACK_ENV'].to_s)
end

Dotenv.load File.join(Haiku.config.root, ".env")
dotenv_file = File.join(Haiku.config.root, ".env.#{Haiku.config.env}")
Dotenv.overload(dotenv_file) if File.exist?(dotenv_file)
Dotenv.overload('.env.custom') if Haiku.config.env.development?

ActionMailer::Base.view_paths = File.join(Haiku.config.root, 'app', 'views')
# Make sure that sendmail "envelope sender" is set to a server with a valid MX record.
# This will hopefully help us avoid some spam filters. Ask Paul/Marcos for details.
ActionMailer::Base.sendmail_settings[:arguments] ||= ""
unless ActionMailer::Base.sendmail_settings[:arguments] =~ /\b-f\s/
  ActionMailer::Base.sendmail_settings[:arguments] += " -f #{ENV['NOREPLY_EMAIL']}"
end

preload = [
  './config/initializers/*.rb',
#   './lib/**/*.rb',
#   './app/helpers/**/*.rb',
#   './app/mixins/**/*.rb',
#   './app/models/**/*.rb',
#   './app/entities/**/*.rb',
  './app/api/**/*.rb'
]
#
preload.each do |dir|
  Dir[dir].each { |f| require f }
end


require 'hk_bot'
require 'haiku_app'
