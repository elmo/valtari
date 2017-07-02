class AddGroupToDealRoomUpload < ActiveRecord::Migration[5.0]
  def change
    add_column :deal_room_uploads, :group, :string
    add_index :deal_room_uploads, :group
  end
end
