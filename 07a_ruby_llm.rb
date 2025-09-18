require 'pp'
require 'ruby_llm'

class Weather < RubyLLM::Tool
  description "Get current weather"
  param :latitude
  param :longitude

  def execute(latitude:, longitude:)
    url = "https://api.open-meteo.com/v1/forecast?latitude=#{latitude}&longitude=#{longitude}&current=temperature_2m,wind_speed_10m"
    JSON.parse(Faraday.get(url).body)
  end
end

lat,long = 38.9536, 94.7336 # Lenexa, KS

wthr = Weather.new
pp wthr.execute(latitude: lat, longitude: long)
