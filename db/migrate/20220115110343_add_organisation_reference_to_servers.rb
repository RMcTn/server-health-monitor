class AddOrganisationReferenceToServers < ActiveRecord::Migration[7.0]
  def change
    add_reference :servers, :organisation, null: false
  end
end
