class CreateOpportunities < ActiveRecord::Migration[5.0]
  def change
    create_table :opportunities do |t|
      t.string :title
      t.integer :revenue_id
      t.integer :ebitda_id
      t.integer :user_id
      t.integer :industry_id
      t.integer :revenue_amount
      t.integer :ebidta_amount
      t.timestamps
    end
    add_index(:opportunities, :revenue_id)
    add_index(:opportunities, :user_id)
    add_index(:opportunities, :industry_id)
    add_foreign_key(:opportunities, :revenues)
    add_foreign_key(:opportunities, :users)
    add_foreign_key(:opportunities, :industries)
  end
end
