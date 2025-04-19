require 'json'

def perplexity_score(prmpt, resp, perplexity_model='sonar')
  prompt = prmpt.to_s.tr("'",'').tr('"','')
  response = resp.to_s.tr("'",'').tr('"','')

  token = ENV['PERPLEXITY_API_KEY']
  cmd = <<~CMD
curl -s --location 'https://api.perplexity.ai/chat/completions' \
--header 'accept: application/json' \
--header 'content-type: application/json' \
--header 'Authorization: Bearer #{token}' \
--data '{
  "model": "#{perplexity_model}",
  "messages": [
    {
      "role": "system",
      "content": "Be precise and concise."
    },
    {
      "role": "user",
      "content": "Given the prompt <PROMPT>#{prompt}</PROMPT> score on a scale of 1 to 10 (1 being poor, 10 being excellent) this response provided by an LLM: <RESPONSE>#{response}</RESPONSE>. Always begin your response with: SCORE = "
    }
  ]
}'
  CMD
  # puts cmd
 
  perp_resp = `#{cmd}`
  data = JSON.parse(perp_resp)
  # pp data

  if data['choices']
    content = data['choices'].first['message']['content']
  else
    content = "Error in calling Perplexity"
    pp perp_resp
  end

  ret_val = '"' + content.to_s.tr("\n",' ').squeeze(' ').strip + '"'

  ret_val
end

prmpt = 'What is the length of you "large context window"?'
resp  = %Q(As an artificial intelligence, I don't have a concept of "context window" or token count. This refers to internal mechanisms within specific models like Transformers, which are used for natural language processing tasks. The size can vary greatly depending on the specific model architecture and its configuration. For instance, a typical Transformer-based model might process text with hundreds of thousands of tokens per batch.)

puts perplexity_score(prmpt, resp)

