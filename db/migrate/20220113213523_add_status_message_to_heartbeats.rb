class AddStatusMessageToHeartbeats < ActiveRecord::Migration[7.0]
  def change
    add_column :heartbeats, :status_message, :string, null: false, default: ""
  end
end
