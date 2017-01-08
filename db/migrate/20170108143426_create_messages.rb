class CreateMessages < ActiveRecord::Migration[5.0]
  def change
    create_table :messages do |t|
      t.integer :user_id
      t.integer :recipient_id
      t.integer :thread_id
      t.string :subject
      t.text :body
      t.boolean :opened
      t.timestamps
    end
    add_index(:messages, :user_id)
    add_index(:messages, :recipient_id)
    add_foreign_key(:messages, :users)
  end
end
