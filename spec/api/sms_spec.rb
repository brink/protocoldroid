require 'spec_helper'

describe HaikuBot::SMS do
  include Rack::Test::Methods

  def app
    HaikuBot::API
  end

  it 'responds with xml' do
    get '/api/sms', :Body => 'hello', :From => '222'

    expect(last_response.status).to eq(200)
    expect(last_response.content_type).to eq("text/xml")
  end

  
end
