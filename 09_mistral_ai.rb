require 'mistral-ai'

client = Mistral.new(
  credentials: { api_key: ENV['MISTRAL_API_KEY'] },
  options: { server_sent_events: true }
)

result = client.chat_completions(
  { model: 'mistral-medium',
    messages: [{ role: 'user', content: 'hi!' }] }
)

pp result
puts;puts result['choices'].first['message']['content']

####################
sample_result = {"id"=>"14b6a1dc29054308b76b7d55e6dc24b4",
 "object"=>"chat.completion",
 "created"=>1739651882,
 "model"=>"mistral-medium",
 "choices"=>
  [{"index"=>0,
    "message"=>
     {"role"=>"assistant",
      "tool_calls"=>nil,
      "content"=>
       "Hello! How can I help you today? If you have any questions or need assistance with something, feel free to ask. I'm here to help.\n" +
       "\n" +
       "If you're not sure what you want to ask, here are a few ideas to get you started:\n" +
       "\n" +
       "* You can ask me to explain a concept or provide information on a topic.\n" +
       "* You can ask me to help you solve a problem or find the answer to a question.\n" +
       "* You can ask me to recommend a book, movie, or other resource on a topic you're interested in.\n" +
       "* You can ask me to generate a random idea or suggestion for you.\n" +
       "\n" +
       "I'm looking forward to hearing from you!"},
    "finish_reason"=>"stop"}],
 "usage"=>{"prompt_tokens"=>10, "total_tokens"=>157, "completion_tokens"=>147}}

