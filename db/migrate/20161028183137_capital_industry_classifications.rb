class CapitalIndustryClassifications < ActiveRecord::Migration[5.0]
  def change
    create_table :capital_industry_classifications do |t|
      t.integer :capital_id
      t.integer :industry_classification_id
    end
  end
end
