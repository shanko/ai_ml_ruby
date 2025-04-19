require 'langchain'
require 'faraday'

Langchain.logger.level = Logger::ERROR

model = 'deepseek-r1'
llm = Langchain::LLM::Ollama.new(default_options: {
  chat_model: model,
  completion_model: model,
  embedding_model: model,
})

sys_prompt = 'Translate the following from English to Italian'
usr_prompt = 'Hello'

ai_summary = ''
messages = [
    {role: "system", content: sys_prompt},
    {role: "user", content: usr_prompt},
  ]
llm.chat(messages: messages) do |r|
  resp = r.chat_completion
  ai_summary += "#{resp}"
  print resp
end

puts '---------'
puts usr_prompt
puts ai_summary
puts '---------'

###################
usr_prompt = 'How are you?'

# Send the prompt to the Ollama model and get a response
messages = [
    {role: "system", content: sys_prompt},
    {role: "user", content: usr_prompt},
  ]
response = llm.chat(messages: messages)

# Output the response
puts '---------------'
puts usr_prompt
puts "Ollama Response: #{response.raw_response['message']['content']}"

