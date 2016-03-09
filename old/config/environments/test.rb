Grape::API.logger = Logger.new(STDOUT)

Grape::API.logger.level = ::Logger::INFO

ActionMailer::Base.delivery_method = :test
ActionMailer::Base.perform_deliveries = true
ActionMailer::Base.deliveries = []
