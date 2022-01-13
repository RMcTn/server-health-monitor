class CreateRequests < ActiveRecord::Migration[7.0]
  def change
    create_table :requests do |t|
      t.string :status_code, null: false
      t.datetime :request_time, null: false
      t.references :server, null: false

      t.timestamps
    end
  end
end
