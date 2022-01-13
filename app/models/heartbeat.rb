class Heartbeat < ApplicationRecord
  belongs_to :server

  after_create_commit {
    broadcast_prepend_to server
  }
end
