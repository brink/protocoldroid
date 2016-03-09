module HaikuBot
  class ContentType < Grape::API
    format :json
    content_type :txt, 'text/plain'
    content_type :xml, 'application/xml'
    content_type :json, 'application/json'

    desc 'Returns a plain text file.'
    get 'plain_text' do
      content_type 'text/plain'
      'A red brown fox jumped over the road.'
    end

    desc 'Returns a response in either XML or JSON format.'
    get 'mixed' do
      { data: 'A red brown fox jumped over the road.' }
    end
  end
end
