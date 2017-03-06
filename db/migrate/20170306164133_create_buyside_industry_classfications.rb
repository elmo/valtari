class CreateBuysideIndustryClassfications < ActiveRecord::Migration[5.0]
  def change
    create_table :buyside_industry_classifications do |t|
       t.integer "buyside_id"
       t.integer "industry_classification_id"
    end
  end
end
