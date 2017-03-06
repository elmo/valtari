class CreateBuysides < ActiveRecord::Migration[5.0]
  def change
    create_table :buysides do |t|
      t.string :title
      t.integer :user_id
      t.integer :geo_id
      t.string :stage
      t.string :city
      t.string :state
      t.string :postal_code
      t.decimal :revenue_lower, precision: 8, scale: 2
      t.decimal :revenue_upper, precision: 8, scale: 2
      t.decimal :ebitda_lower, precision: 8, scale: 2
      t.decimal :ebitda_upper, precision: 8, scale: 2
      t.timestamps
    end
    add_index(:buysides, :stage)
  end
end
