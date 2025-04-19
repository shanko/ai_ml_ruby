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

  def chat_completion(prompt:, model:)
    begin
      response = @client.completions(
        parameters: {
          model: model,
          prompt: prompt,
          max_tokens: 300
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

  # Example 1: Single interaction with context
  system_context = <<~CONTEXT
    You are a helpful AI assistant with expertise in programming and technology.
    Provide clear, concise answers.
  CONTEXT

  user_prompt = %Q(
A business owner who runs her own estate planning practice is looking to build a new website for her practice that helps her get more clients. But she doesn’t have a comprehensive list of all of the activities she needs to get the job done. She also wants to know how long the job will take, and how much it will cost. Write a list of all activities for her website development project. List these steps in a clear, numbered format and include the following: 1. person hours needed for each activity,  2. the cost per hour for each task based on its complexity, 3. Due Datetime for each task, 4. Complexity on a scale of 1 to 5. Assume a minimum cost of $25 as the baseline cost. Respond in the JSON format. Include this original prompt in the response.
  ) 

#  user_prompt = "What is your knowledge cutoff date?"
 
  puts client.chat_with_context(system_context: system_context, user_prompt: user_prompt, model: model)
  puts '---------'

  # Example 2: Chat completion
  puts client.chat_completion(prompt: "The food was delicious and the waiter...", model: model)
end

main('llama3.2' || 'qwen2.5-coder:14b') if __FILE__ == $0

