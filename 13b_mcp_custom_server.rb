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

# Client request
# {"jsonrpc":"2.0","id":"0","method":"ping"}
# {"jsonrpc":"2.0","id":"1","method": "add", "params": { "a": 5, "b": 3 } }
# {"jsonrpc":"2.0","id":"2","method":"tools/list"}
# {"jsonrpc":"2.0","id":"3","method":"tools/call","params":{"name":"add","arguments":{ "a": 5, "b": 3 }}}
