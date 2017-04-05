class RemoveBuysides < ActiveRecord::Migration[5.0]
  def change
    drop_table :buysides
    drop_table :buyside_industry_classifications
  end
end
