module HaikuBot
  class SMS < Grape::API
    format :xml

    params do
      requires :Body, :From, type: String
    end

    get '/sms' do
      # ToCountry=US&
      # ToState=WA&
      # SmsMessageSid=SMf1588819460184c08bed6a3ffa8c1dac&
      # NumMedia=0&
      # ToCity=RENTON&
      # FromZip=98074&
      # SmsSid=SMf1588819460184c08bed6a3ffa8c1dac&
      # FromState=WA&
      # SmsStatus=received
      # &FromCity=ISSAQUAH
      # &Body=High
      # &FromCountry=US
      # &To=%2B14255288067
      # &ToZip=98055
      # &NumSegments=1
      # &MessageSid=SMf1588819460184c08bed6a3ffa8c1dac
      # &AccountSid=ACec18569bf54e0346289426105e9bcde1
      # &From=%2B14253943058
      # &ApiVersion=2010-04-01
      content_type 'text/xml'
      # @twilio_number = ENV['TWILIO_NUMBER']
      # @client = Twilio::REST::Client.new ENV['TWILIO_ACCOUNT_SID'], ENV['TWILIO_AUTH_TOKEN']
      #
      # message = @client.account.messages.create(
      #   :from => @twilio_number,
      #   :to => phone_number,
      #   :body => alert_message,
      #   # US phone numbers can make use of an image as well.
      #   # :media_url => image_url
      # )
      # puts message.to

      msg = if params[:Body].match /bunny/i
         "Quiet white bunny / hops along the grassy ground / munching on some sticks 🐰"
      else
        "hello #{params[:From]}!"
      end

      twiml = Twilio::TwiML::Response.new do |r|
         r.Message msg
       end
    end



  end
end
