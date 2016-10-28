class CreateCapitals < ActiveRecord::Migration[5.0]
  def change
    create_table :capitals do |t|
      t.integer :user_id
      t.string :title
      t.decimal :revenue, :decimal, precision: 8, scale: 2
      t.timestamps
    end
  end
end
