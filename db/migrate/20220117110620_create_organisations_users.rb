class CreateOrganisationsUsers < ActiveRecord::Migration[7.0]
  def change
    create_join_table :organisations, :users do |t|
      t.index :organisation_id
      t.index :user_id
    end
  end
end
