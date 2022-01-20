class Heartbeat < ApplicationRecord
  belongs_to :server, touch: true
  default_scope { order(id: :desc) }

  after_create_commit {
    broadcast_prepend_to server, locals: {server: server, organisation: server.organisation}
    
    server_header_dom_id = "server_" + server.id.to_s + "-server-header"
    broadcast_replace_to(server, target: server_header_dom_id, partial: 'servers/server_header', locals: {server: server, organisation: server.organisation})


    # TODO NOTE SPEEDUP Fire this off for every heartbeat? Any better way? Is it even a problem?
    if server.last_request_failed? 
      broadcast_prepend_to server.organisation, target: "problem_servers", partial: 'servers/problem_server', locals: {server: server, organisation: server.organisation}
    else 
      problem_server_dom_id = "server_" + server.id.to_s + "-problem"
      broadcast_remove_to server.organisation, target: problem_server_dom_id
    end
  }
end
