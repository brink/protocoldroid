module HaikuBot
  class API < Grape::API
    rescue_from :all do |e|
      Rack::Response.new([e.message], 500, 'Content-type' => 'text/error').finish
    end
    prefix 'api'
    format :json
    mount ::HaikuBot::Ping
    mount ::HaikuBot::SMS
    mount ::HaikuBot::RescueFrom
    mount ::HaikuBot::PathVersioning
    mount ::HaikuBot::HeaderVersioning
    mount ::HaikuBot::PostPut
    mount ::HaikuBot::WrapResponse
    mount ::HaikuBot::PostJson
    mount ::HaikuBot::GetJson
    mount ::HaikuBot::ContentType
    mount ::HaikuBot::Entities::API
    add_swagger_documentation api_version: 'v1'

  end
end
