module HaikuBot
  class ProtocolDroid
    class MessageTransport
      def self.generate_transport(message)
        SMSTransport.new
      end

    end

    class SMSTransport < MessageTransport
      def send_message_from(provider)
        twiml = Twilio::TwiML::Response.new do |r|
           r.Message provider.to_message
         end
       end
    end

    class HipChatTransport < MessageTransport; end
  end
end
