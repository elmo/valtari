class CreateFollowings < ActiveRecord::Migration[5.0]
  def change
    create_table :followings do |t|
      t.integer :user_id
      t.integer :other_user_id
      t.timestamps
    end
    add_index(:followings, :user_id)
    add_index(:followings, :other_user_id)
  end
end
