require "langchain"
require 'openai'
require "faraday"

Langchain.logger.level = Logger::ERROR

# llm = Langchain::LLM::Ollama.new(default_options: {chat_model: "llama3.2-vision:11b"})
# llm = Langchain::LLM::Anthropic.new(api_key: ENV["ANTHROPIC_API_KEY"])

llm = Langchain::LLM::OpenAI.new(api_key: ENV["OPENAI_API_KEY"],
        default_options: { temperature: 0.7, response_format: { type: 'json_object' }, chat_model: "gpt-4o" })

assistant = Langchain::Assistant.new(llm: llm)
url = 'https://images.ctfassets.net/lzny33ho1g45/34uUk6ZasflqngpeV5QvyC/823b4f03801a046a475dd4c85f908e7c/image3.jpg'
#puts `wget #{url} -O image3.jpg`
`open image3.jpg`

# 'https://www.invoicesimple.com/wp-content/uploads/2018/06/Sample-Invoice-printable.png',
# "https://gist.githubusercontent.com/andreibondarev/b6f444194d0ee7ab7302a4d83184e53e/raw/099e10af2d84638211e25866f71afa7308226365/sf-cable-car.jpg",

#puts url
response = assistant.add_message_and_run(
  image_url: url,
  content: "Please describe this image and respond in JSON format"
)

puts response[1].content
