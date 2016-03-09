module HaikuBot
  class HkBot < Grape::API
    prefix 'api/v2/hkbot'
    format :json

    # mount ::Haiku::Ping

  end


end
