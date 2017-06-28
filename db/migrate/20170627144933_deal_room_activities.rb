class DealRoomActivities < ActiveRecord::Migration[5.0]
  def change
    create_table :deal_room_activities do |t|
       t.integer :user_id
       t.integer :deal_room_id
       t.string :message
       t.timestamps
    end
    add_index(:deal_room_activities, :deal_room_id)
  end
end
