class CreateCmiAccesses < ActiveRecord::Migration[5.0]
  def change
    create_table :cim_accesses do |t|
      t.integer :user_id
      t.integer :cim_id
      t.string :ip
      t.timestamps
    end
  end
end
