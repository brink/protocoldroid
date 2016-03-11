module HaikuBot
  class ProtocolDroid
    class ApplicationBot
      attr_accessor :input_message, :respond_with

      def initialize(message)
        @input_message = message
        @respond_with = ''
      end

      def self.matchers
        ['echo']
      end

      def self.understands(message)
        matchers.any? {|w| message.include? w}
      end

      def self.resolve_provider_by_keywords(message)
        if PoemBot.understands message
          PoemBot.new(message)
        else
          EchoBot.new(message)
        end
      end

      def to_message
        construct_message rescue ''
      end

      def construct_message
        @respond_with
      end
    end

    class PoemBot < ApplicationBot
      def self.matchers
        ['poem','haiku']
      end
    end

    class EchoBot < ApplicationBot
      def construct_message
        @respond_with = 'You said: "' + @input_message +'" which I do not recognize'
      end

    end
    class ErrorLogBot < ApplicationBot
      def self.matchers
        ['log','error log', 'errorlog', 'errlog']
      end
    end

    class AssignmentsBot < ApplicationBot; end

  end
end
