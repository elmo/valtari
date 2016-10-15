class CreateCampaigns < ActiveRecord::Migration[5.0]
  def change
    create_table :campaigns do |t|
      t.string :title
      t.integer :revenue_id
      t.integer :ebitda_id
      t.integer :user_id
      t.timestamps
    end
  end
end
