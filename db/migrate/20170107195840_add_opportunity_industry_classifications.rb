class AddOpportunityIndustryClassifications < ActiveRecord::Migration[5.0]
  def change
    create_table :opportunity_industry_classifications do |t|
      t.integer :opportunity_id
      t.integer :industry_classification_id
    end
  end
end
