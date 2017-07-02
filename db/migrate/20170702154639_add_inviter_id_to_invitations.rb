class AddInviterIdToInvitations < ActiveRecord::Migration[5.0]
  def change
    add_column :deal_room_invitations, :status, :string
    add_index :deal_room_invitations, :status
  end
end
