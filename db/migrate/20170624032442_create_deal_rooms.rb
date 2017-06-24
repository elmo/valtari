class CreateDealRooms < ActiveRecord::Migration[5.0]
  def change
    create_table :deal_rooms do |t|
      t.string :name
      t.integer :user_id
      t.timestamps
    end
    add_index(:deal_rooms, :user_id)
  end
end
