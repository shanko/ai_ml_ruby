require 'base64'
require 'net/http'
require 'uri'
require 'json'

def encode_image(image_path)
  image_data = File.binread(image_path)
  encoded_image = Base64.strict_encode64(image_data)
  return encoded_image
end

def desc_image(image_url, prompt="What is in this image?")
  puts image_url
  model = "gpt-4o"

  uri = URI.parse("https://api.openai.com/v1/chat/completions")
  request = Net::HTTP::Post.new(uri, 'Content-Type' => 'application/json')
  request['Authorization'] = "Bearer #{ENV['OPENAI_API_KEY']}"

  payload = {
    model: model,
    messages: [
      {
        role: "user",
        content: [
          { type: "text", text: prompt },
          { type: "image_url", 
            image_url: { url: image_url }
          }
        ]
      }
    ],
    max_tokens: 300
  }.to_json

  request.body = payload

  req_options = { use_ssl: uri.scheme == "https" }
  response = Net::HTTP.start(uri.hostname, uri.port, req_options) do |http|
    http.request(request)
  end

  return JSON.parse(response.body)['choices'][0]['message']['content']
end

def extract_text_from_image(image_path, prompt="What is in this image?")
  model = "gpt-4o"
  base64_image = encode_image(image_path)

  uri = URI.parse("https://api.openai.com/v1/chat/completions")
  request = Net::HTTP::Post.new(uri, 'Content-Type' => 'application/json')
  request['Authorization'] = "Bearer #{ENV['OPENAI_API_KEY']}"

  payload = {
    model: model,
    messages: [
      {
        role: "user",
        content: [
          { type: "text", text: prompt },
          { type: "image_url", 
            image_url: { url: "data:image/jpeg;base64,#{base64_image}" }
          }
        ]
      }
    ],
    max_tokens: 300
  }.to_json

  request.body = payload

  req_options = { use_ssl: uri.scheme == "https" }
  response = Net::HTTP.start(uri.hostname, uri.port, req_options) do |http|
    http.request(request)
  end

  return JSON.parse(response.body)['choices'][0]['message']['content']
end

file_name = ARGV[0] || "AI-In-Health.png"
puts extract_text_from_image(file_name)
puts
puts desc_image('https://images.ctfassets.net/lzny33ho1g45/34uUk6ZasflqngpeV5QvyC/823b4f03801a046a475dd4c85f908e7c/image3.jpg')

