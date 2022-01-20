class AddProtocolToServers < ActiveRecord::Migration[7.0]
  def change
    add_column :servers, :protocol, :string, null: false, default: "http://"
  end
end
