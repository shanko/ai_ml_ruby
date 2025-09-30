require 'mcp'
require 'faraday'
require 'mcp/server/transports/stdio_transport'
require 'mcp/server/transports/streamable_http_transport'

server = MCP::Server.new(name: "my_server")
transport = MCP::Server::Transports::HTTP.new(server)
server.transport = transport

# When tools change, notify clients
server.define_tool(name: "new_tool") { |**args| { result: "ok" } }
server.notify_tools_list_changed
