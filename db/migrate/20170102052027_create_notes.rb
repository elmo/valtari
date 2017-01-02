class CreateNotes < ActiveRecord::Migration[5.0]
  def change
    create_table :notes do |t|
      t.integer :user_id
      t.text :body
      t.string :notable_type
      t.integer :notable_id
      t.timestamps
    end
    add_index :notes, [:notable_type, :notable_id]
  end
end
