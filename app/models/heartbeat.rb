class Heartbeat < ApplicationRecord
  belongs_to :server

  after_create_commit {
    broadcast_prepend_to server, locals: {server: server, organisation: server.organisation}
    
    server_header_dom_id = "server_" + server.id.to_s + "-server-header"
    broadcast_replace_to(server, target: server_header_dom_id, partial: 'servers/server_header', locals: {server: server, organisation: server.organisation})
  }
end
