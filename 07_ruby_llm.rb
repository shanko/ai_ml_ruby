# https://rubyllm.com/
# Section: Quick Start
require 'ruby_llm'

RubyLLM.configure do |config|
  config.openai_api_key = ENV['OPENAI_API_KEY']
  config.anthropic_api_key = ENV['ANTHROPIC_API_KEY']
  config.gemini_api_key = ENV['GEMINI_API_KEY']
  config.deepseek_api_key = ENV['DEEPSEEK_API_KEY']
end

# Start chatting
#chat = RubyLLM.chat
chat = RubyLLM.chat(model: 'claude-3-7-sonnet-20250219')
response = chat.ask "Who are the 3 most recent US presidents?"
puts response.content
puts '---------------'

# Analyze audio recordings
# respone = chat.with_model('gpt-4o-audio-preview').ask "Describe this meeting", with: { audio: "ruby.wav" }
# puts response.content
# puts '---------------'

# Generate images
puts "Generating a composite image of dog and cats, please wait..."
image = RubyLLM.paint("a composite image of dog and cats")
cmd = %Q(wget -q "#{image.url}" -O ruby_image.png)
puts cmd; puts
puts `#{cmd}`
puts `open ruby_image.png`
puts '---------------'

# Analyze PDF documents with Claude
# claude_chat = RubyLLM.chat(model: 'claude-3-7-sonnet-20250219')
# response = claude_chat.ask "Summarize this document", with: { pdf: "Soil-Biology-Primer.pdf" }
# puts response.content
