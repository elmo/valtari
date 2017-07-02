class AddGroupToDealRoomAuthorization < ActiveRecord::Migration[5.0]
  def change
    add_column :deal_room_authorizations, :group, :string
    add_index :deal_room_authorizations, :group
  end
end
