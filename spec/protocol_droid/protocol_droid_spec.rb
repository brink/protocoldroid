require 'spec_helper'

describe HaikuBot::ProtocolDroid do

  describe 'for the right keywords' do
    it 'resolves the provider based on keywords' do
      msg = "asdfasdf asdfasdf asdfasdf asdfasdf"
      expect(HaikuBot::ProtocolDroid::ApplicationBot).to receive(:resolve_provider_by_keywords).with(msg).once
      HaikuBot::ProtocolDroid.generate_message_provider msg
    end

    describe 'EchoBot' do
      it 'generates an echo provider if no matching keywords' do
        msg = "asdfasdf asdfasdf asdfasdf asdfasdf"

        provider = HaikuBot::ProtocolDroid.generate_message_provider msg
        expect(provider).to be_kind_of(HaikuBot::ProtocolDroid::EchoBot)
      end

      it 'responds with "you said <message>"' do
        msg = "asdfasdf asdfasdf asdfasdf asdfasdf"

        provider = HaikuBot::ProtocolDroid.generate_message_provider msg
        expect(provider.to_message).to eq('You said: "'+ msg + '" which I do not recognize')
      end
    end

    describe 'PoemBot' do
      it 'generates a haiku (poem) provider' do
        ["give me a poem", "poem", "tell me a haiku", "which haiku is your favorite?", "haiku"].each do |message|
          provider = HaikuBot::ProtocolDroid.generate_message_provider message
          expect(provider).to be_kind_of(HaikuBot::ProtocolDroid::PoemBot)
        end
      end

    end
    it 'generates an assignment provider'
    it 'generates an errorlog provider' do
      ["logs", "view logs", "show me the last errors"].each do |message|

        provider = HaikuBot::ProtocolDroid.generate_message_provider message
        expect(provider).to be_kind_of(HaikuBot::ProtocolDroid::ErrorLogBot)
      end

    end

  end

end
