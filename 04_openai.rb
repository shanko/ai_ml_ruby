require 'openai'

class OllamaClient
  attr_accessor :client

  def initialize(base_url: "http://localhost:11434/v1")
    @client = OpenAI::Client.new( uri_base: base_url)
  end

  def chat_with_context(system_context:, user_prompt:, model:, temperature: 0.0)
    begin
      messages = [
        { role: 'system', content: system_context },
        { role: 'user', content: user_prompt }
      ]

    content = ''
    count = 0
    response = @client.chat(
      parameters: {
        model: model,
        messages: messages,
        temperature: temperature,
        response_format: { type: 'json_object' },
        stream: proc do |chunk, _bytesize|
          count += 1
          str = chunk.dig("choices", 0, "delta", "content")
          print('.')
          #print(str)
          content += str
        end
      })
    puts(count)
    content.strip
    rescue StandardError => e
      "#{__LINE__} Error: #{e.message}"
    end
  end

  def chat_completion(temp, prompt:, model:, max_tokens: 300)
    begin
      response = @client.completions(
        parameters: {
          model: model,
          prompt: prompt,
          temperature: temp,
          max_tokens: max_tokens,
        }
      )

      response['choices'].map { |c| c['text'] }
    rescue StandardError => e
      "#{__LINE__} Error: #{e.message}"
    end
  end
end

def main(model)
  # Initialize the client
  client = OllamaClient.new

  # Example 1: Chat completion
  prompt = "The food was delicious and the waiter..."
  print(prompt)
  puts client.chat_completion(0.0, prompt: prompt, model: model, max_tokens: 600)
end

model = 'llama3.2'
model = 'granite3.1-moe:3b'
puts model
main(model) if __FILE__ == $0

