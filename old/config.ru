require File.expand_path('../config/environment', __FILE__)

# if ENV['RACK_ENV'] == 'development'
#   puts "Loading NewRelic in developer mode ..."
#   require 'new_relic/rack/developer_mode'
#   use NewRelic::Rack::DeveloperMode
# end
#
# NewRelic::Agent.manual_start

# This app should treat CloudFlare IP addresses as trusted proxies
# That is, if it sees a CloudFlare IP address in the X-Forwarded-For header
# it should realize that the CloudFlare IP address is *not* the customer's IP address.
ips = ENV['KNOWN_PROXY_IPS'].to_s.split(/\s+/)
if !ips.empty?
  use RemoteIpProxyScrubber.filter_middleware, *ips
end

use ActiveRecord::ConnectionAdapters::ConnectionManagement

run Haiku::App.instance
