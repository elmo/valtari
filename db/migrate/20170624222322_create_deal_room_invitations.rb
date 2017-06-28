class CreateDealRoomInvitations < ActiveRecord::Migration[5.0]
  def change
    create_table :deal_room_invitations do |t|
      t.integer :deal_room_id
      t.integer :user_id
      t.string :email
      t.timestamps
    end
  end
end
