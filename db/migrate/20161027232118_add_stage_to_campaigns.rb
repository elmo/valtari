class AddStageToCampaigns < ActiveRecord::Migration[5.0]
  def change
    add_column :campaigns, :stage, :string
    add_index :campaigns, :stage
  end
end
