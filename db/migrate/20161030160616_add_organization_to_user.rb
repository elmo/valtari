class AddOrganizationToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :organization_id, :integer
    add_column :users, :declined_to_state_organization, :boolean, default: false
  end
end
