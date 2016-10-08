class ChangeColumnTypes < ActiveRecord::Migration[5.0]
  def change
    change_column :businesses, :revenue, :decimal, precision: 8, scale: 2
  end
end
