module HaikuBot
  class PathVersioning < Grape::API
    version 'vendor', using: :path, vendor: 'haiku', format: :json
    desc 'Returns haiku.'
    get do
      { path: 'haiku' }
    end
  end
end
