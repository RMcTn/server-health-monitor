class AddPrimaryKeyToOrganisationsUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :organisations_users, :id, :primary_key
  end
end
