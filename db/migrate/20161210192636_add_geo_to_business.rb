class AddGeoToBusiness < ActiveRecord::Migration[5.0]
  def change
    add_column :businesses, :geo_id, :integer
    add_index(:businesses, :geo_id)
    Business.all.save
  end
end
