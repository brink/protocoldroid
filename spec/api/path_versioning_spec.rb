require 'spec_helper'

describe HaikuBot::API do
  include Rack::Test::Methods

  def app
    HaikuBot::API
  end

  it 'vendored path' do
    get '/api/vendor'
    expect(last_response.body).to eq({ path: 'haiku' }.to_json)
  end
end
