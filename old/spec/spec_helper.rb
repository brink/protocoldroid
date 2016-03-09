require 'rubygems'
require 'spork'
# uncomment the following line to use spork with the debugger
# require 'spork/ext/ruby-debug'

Spork.prefork do
  # Loading more in this block will cause your tests to run faster. However,
  # if you change any configuration or code from libraries loaded here, you'll
  # need to restart spork for it take effect.

  require 'awesome_print'
  require 'database_cleaner'
  require 'should_not/rspec'

  ENV["RACK_ENV"] ||= 'test'

  require 'rack/test'

  require 'simplecov'
  SimpleCov.start

  module HaikuBot
    class << self; attr_accessor :capture_exceptions; end
  end
  Haiku.capture_exceptions = false

  require File.expand_path("../../config/environment", __FILE__)

  Dir["./spec/support/**/*.rb"].each { |f| require f }

  RSpec.configure do |config|
    # config.treat_symbols_as_metadata_keys_with_true_values = true # deprecated, by default it's true
    config.filter_run focus: true
    config.filter_run pending: false
    config.run_all_when_everything_filtered = true
    config.include RackSpecHelper

    config.before(:suite) do
      DatabaseCleaner.strategy = :transaction
      DatabaseCleaner.clean_with(:truncation, pre_count: true)
    end

    config.before(:each) do
      DatabaseCleaner.start
    end

    config.after(:each) do
      DatabaseCleaner.clean
    end

    config.after(:all) do
      if Haiku.config.env.test?
        # `rm -rf #{File.join(Haiku.config.root, 'data_test')}`
        FileUtils.rm_rf(Dir["#{Haiku.config.root}/data_test"])
      end
    end

    config.order = "random"
  end

  # require 'capybara/rspec'
  # Capybara.configure do |config|
  #   config.app = Haiku::App.new
  #   config.server_port = 9293
  # end

  Haiku.configure do |config|
    config.data_dir = File.join(config.root, 'data_test')
  end
end

Spork.each_run do
  # This code will be run each time you run your specs.

end
