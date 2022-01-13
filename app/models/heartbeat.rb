class Heartbeat < ApplicationRecord
  belongs_to :server

  after_create_commit {
    broadcast_append_to server
  }
end
