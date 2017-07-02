class AddInviterIdToInvitation < ActiveRecord::Migration[5.0]
  def change
     add_column(:deal_room_invitations, :inviting_user_id, :integer)
     add_index(:deal_room_invitations, :inviting_user_id)
  end
end
