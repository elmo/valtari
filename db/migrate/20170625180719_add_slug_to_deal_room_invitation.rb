class AddSlugToDealRoomInvitation < ActiveRecord::Migration[5.0]
  def change
    add_column :deal_room_invitations, :slug, :string
    add_index :deal_room_invitations, :slug
  end
end
