class CreateUserIndustryClassifications < ActiveRecord::Migration[5.0]
  def change
    create_table :user_industry_classifications do |t|
       t.integer "user_id"
       t.integer "industry_classification_id"
    end
  end
end
