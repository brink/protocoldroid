logfile = File.open(File.join(Haiku.config.root, 'log', 'active_record.log'), 'a')
logfile.sync = true
ActiveRecord::Base.logger = Logger.new(logfile)

# Grape::API.logger = ActiveSupport::TaggedLogging.new(Logger::Syslog.new('haiku_core', Syslog::LOG_LOCAL1))
Grape::API.logger = Logger.new(STDOUT)

Grape::API.logger.level = ::Logger::DEBUG

ActionMailer::Base.raise_delivery_errors = true
ActionMailer::Base.perform_deliveries = true
ActionMailer::Base.delivery_method = :sendmail

# ActionMailer::Base.smtp_settings = {
#   :address        => 'smtp.gmail.com',
#   :domain         => 'mail.google.com',
#   :port           => 587,
#   :user_name      => '',
#   :password       => '',
#   :authentication => :plain,
#   :enable_starttls_auto => true
# }
