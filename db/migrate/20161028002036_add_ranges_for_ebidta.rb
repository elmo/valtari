class AddRangesForEbidta < ActiveRecord::Migration[5.0]
  def change
    add_column :campaigns, :revenue_lower, :decimal, precision: 8, scale: 2
    add_column :campaigns, :revenue_upper, :decimal, precision: 8, scale: 2
    add_column :campaigns, :ebitda_lower, :decimal, precision: 8, scale: 2
    add_column :campaigns, :ebitda_upper, :decimal, precision: 8, scale: 2
  end
end
