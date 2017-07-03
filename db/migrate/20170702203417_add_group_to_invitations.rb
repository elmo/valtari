class AddGroupToInvitations < ActiveRecord::Migration[5.0]
  def change
    add_column :deal_room_invitations, :group, :string
    add_index :deal_room_invitations, :group
  end
end
