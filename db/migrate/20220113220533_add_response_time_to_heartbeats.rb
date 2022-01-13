class AddResponseTimeToHeartbeats < ActiveRecord::Migration[7.0]
  def change
    add_column :heartbeats, :response_time, :datetime
  end
end
