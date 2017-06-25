class AddSlugToDealRoom < ActiveRecord::Migration[5.0]
  def change
    add_column :deal_rooms, :slug, :string
    add_index(:deal_rooms, :slug)
  end
end
