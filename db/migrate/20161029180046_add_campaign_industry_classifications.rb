class AddCampaignIndustryClassifications < ActiveRecord::Migration[5.0]
  def change
    create_table :campaign_industry_classifications do |t|
      t.integer :campaign_id
      t.integer :industry_classification_id
    end
  end
end
