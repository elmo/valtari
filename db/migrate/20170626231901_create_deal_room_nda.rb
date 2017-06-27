class CreateDealRoomNda < ActiveRecord::Migration[5.0]
  def change
    create_table :deal_room_ndas do |t|
       t.integer :user_id
       t.integer :deal_room_id
       t.integer :deal_room_invitation_id
       t.boolean :i_have_read
       t.boolean :i_agree
       t.string :signature
       t.string :ip_address
       t.timestamps
    end
  end
end
