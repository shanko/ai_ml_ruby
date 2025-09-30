# https://github.com/modelcontextprotocol/ruby-sdk?tab=readme-ov-file#http-transport-layer

require 'mcp'
require 'faraday'

http_transport = MCP::Client::HTTP.new(url: "http://localhost:3000/mcp")
client = MCP::Client.new(transport: http_transport)

# List available tools
tools = client.tools
tools.each do |tool|
  puts <<~TOOL_INFORMATION
    Tool: #{tool.name}
    Description: #{tool.description}
    Input Schema: #{tool.input_schema}
  TOOL_INFORMATION
end

# Call a specific tool
response = client.call_tool(
  tool: tools.first,
  arguments: { message: "Hello, world!" }
)

