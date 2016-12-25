class CreateUserBusinesses < ActiveRecord::Migration[5.0]
  def change
    create_table :user_businesses do |t|
      t.integer :user_id
      t.integer :business_id
    end
    add_index(:user_businesses, [:user_id, :business_id])
  end
end
