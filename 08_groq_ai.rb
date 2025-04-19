require 'httparty'
require 'json'

class OpenAICompletion
  def initialize(api_key, model, content)
    @api_key = api_key
    @model = model
    @content = content
  end

  def post_request
    url = 'https://api.groq.com/openai/v1/chat/completions'
    headers = {
      'Authorization' => "Bearer #{@api_key}",
      'Content-Type' => 'application/json'
    }
    body = {
      messages: [{ role: 'user', content: @content }],
      model: @model
    }.to_json

    response = HTTParty.post(url, headers: headers, body: body)
    response
  end
end

# Example usage
api_key = ENV['GROQ_API_KEY']
model = 'llama-3.3-70b-versatile'
content = 'Explain the importance of fast language models'

completion = OpenAICompletion.new(api_key, model, content)
response = completion.post_request

puts response.body
#puts "Status code: #{response.code}"

