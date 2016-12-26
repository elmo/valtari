class CreateSearches < ActiveRecord::Migration[5.0]
  def change
    create_table :searches do |t|
      t.integer :user_id
      t.string :name, :string
      t.string :query, :string
      t.timestamps
    end
  end
end
