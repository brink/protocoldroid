require 'wrap_response_decorator'

module HaikuBot
  class WrapResponse < Grape::API
    use WrapResponseDecorator
    format :json
    namespace :decorated do
      desc 'Returns pong.'
      get :ping do
        { ping: 'pong' }
      end
    end
  end
end
