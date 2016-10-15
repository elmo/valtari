class AddIndustryCodeToCampaign < ActiveRecord::Migration[5.0]
  def change
    add_column :campaigns, :industry_id, :integer
    add_index(:campaigns, :revenue_id)
    add_index(:campaigns, :ebitda_id)
    add_index(:campaigns, :industry_id)
  end
end
