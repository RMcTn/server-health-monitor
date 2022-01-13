class RenameRequestToHeartbeat < ActiveRecord::Migration[7.0]
  def change
    rename_table :requests, :heartbeats
  end
end
