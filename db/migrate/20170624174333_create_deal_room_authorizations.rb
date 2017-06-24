class CreateDealRoomAuthorizations < ActiveRecord::Migration[5.0]
  def change
    create_table :deal_room_authorizations do |t|
      t.integer :user_id
      t.integer :deal_room_id
      t.timestamps
    end
  end
end
