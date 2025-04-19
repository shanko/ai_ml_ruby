require 'ollama-ai'

client = Ollama.new(
  credentials: { address: 'http://localhost:11434' },
  options: { server_sent_events: true }
)

prompt = %Q[
  Find two numbers between 0 and 9 such that their difference is 2 and product is 15. Use linear algebraic techniques. Explain how you arrived at the solution.
]
puts "Prompt:"
puts "-------"
puts prompt

models = `ollama list`
models = "llama3.2"
models.each_line do |m| 
  next if  m.strip == 'NAME'

  tb = Time.now
  puts "Response from #{m}:"
  puts "------------------"
  result = client.generate({ model: m, prompt: prompt })
  
  resp = ''
  result.each do |hash|
    resp += hash['response']
  end
  
  puts resp
  ta = Time.now
  puts "Time taken = #{ta - tb}"
end

