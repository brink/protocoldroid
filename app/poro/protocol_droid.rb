module HaikuBot
  class ProtocolDroid

    def self.generate_transport(message, message_provider)
      HaikuBot::ProtocolDroid::MessageTransport.new(:sms, message_provider)
    end

    def self.generate_message_provider(message)
      return HaikuBot::ProtocolDroid::ApplicationBot.resolve_provider_by_keywords(message)
    end
  end
end
