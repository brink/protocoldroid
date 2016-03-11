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
        # IDEA, carousel of checking each sub bot, and each returns
        # percent confidence of understanding, sort by high low and use first
        # this can handle collisions
        if PoemBot.understands message
          PoemBot.new(message)
        elsif ErrorLogBot.understands message
          ErrorLogBot.new(message)
        else
          EchoBot.new(message)
        end
      end

      def to_message
        construct_message rescue 'I was unable to understand your request'
      end

      def construct_message
        @respond_with
      end
    end

    class PoemBot < ApplicationBot
      POEMS = [
        'Quiet, white bunny / hops along the grassy ground / munching on some sticks',
        'Pretty little bird / flies across the deep, blue sky / looking for a nut',
        'Roses are red / violets are blue / daffodils are yellow / and mums come in a variety of colors',
        "I never met a peanut that I didn't like / I never, ever crush them, when I ride my bike / I always go around them, though this makes my speed lag / until I meet the culprit with the leaky bag"
      ]
      def self.matchers
        ['poem','haiku']
      end

      def show_favorite?
        @input_message.match /favorite/i
      end

      def construct_message
        if @input_message.match /haiku/i
          show_favorite? ? POEMS[0] : POEMS[rand(2)]
        else
          show_favorite? ? POEMS[3] : POEMS[rand(POEMS.size)]
        end
      end
    end

    class EchoBot < ApplicationBot
      def construct_message
        @respond_with = 'You said: "' + @input_message +'" which I do not recognize'
      end

    end
    class ErrorLogBot < ApplicationBot
      def self.matchers
        ['errors','log','error log', 'errorlog', 'errlog']
      end
    end

    class AssignmentsBot < ApplicationBot; end

  end
end
