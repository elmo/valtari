class CreateDealRoomUploads < ActiveRecord::Migration[5.0]
  def change
    create_table :deal_room_uploads do |t|
      t.integer :deal_room_id
      t.integer :user_id
      t.column :upload, :oid, null: false
      t.string :original_file_name
      t.timestamps
    end
  end
end
