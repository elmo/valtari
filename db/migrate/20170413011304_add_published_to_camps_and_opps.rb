class AddPublishedToCampsAndOpps < ActiveRecord::Migration[5.0]
  def change
    add_column :campaigns, :published, :boolean, default: :false
    add_column :opportunities, :published, :boolean, default: :false
    add_index(:campaigns, :published)
    add_index(:opportunities, :published)
  end
end
