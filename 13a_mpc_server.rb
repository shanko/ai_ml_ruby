# https://github.com/modelcontextprotocol/ruby-sdk
require "mcp"
require "mcp/server/transports/stdio_transport"

server = MCP::Server.new(name: "my_server")

# Define a custom method that returns a result
server.define_custom_method(method_name: "add") do |params|
  params[:a] + params[:b]
end

# Create and start the transport
transport = MCP::Server::Transports::StdioTransport.new(server)
transport.open
