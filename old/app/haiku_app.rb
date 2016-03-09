module HaikuBot
  class App
    def initialize
      @filenames = ['', '.html', 'index.html', '/index.html']
      @rack_static = ::Rack::Static.new(
        lambda { [404, {}, []] },
        root: File.expand_path('../../public', __FILE__),
        urls: %w(/)
        )
    end

    def self.instance
      @instance ||= Rack::Builder.new do
        use Rack::Cors do
          allow do
            origins '*'
            resource '*', headers: :any, methods: :get
          end
        end

        # NOTE: Removing this because, the checking is done inside the require_acess_token,
        #   so we have access to the current AccessToken object from the endpoints for further permission checking
        # use Rack::OAuth2::Server::Resource::Bearer, 'Core API' do |req|
        #   AccessToken.verify(req.access_token) || req.invalid_token!
        # end

        run Haiku::App.new
      end.to_app
    end

    def call(env)
      # api
      response = Haiku::API.call(env)

      # Check if the App wants us to pass the response along to others
      if response[1]['X-Cascade'] == 'pass'
        # static files
        request_path = env['PATH_INFO']
        @filenames.each do |path|
          response = @rack_static.call(env.merge('PATH_INFO' => request_path + path))
          return response if response[0] != 404
        end
      end

      response
    end
  end
end
