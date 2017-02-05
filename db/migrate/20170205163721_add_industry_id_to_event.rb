class AddIndustryIdToEvent < ActiveRecord::Migration[5.0]
  def change
    add_column :events, :industry_classification_id, :integer
  end
end
