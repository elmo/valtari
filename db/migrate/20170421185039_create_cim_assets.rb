class CreateCimAssets < ActiveRecord::Migration[5.0]
  def change
    create_table :cim_assets do |t|
      t.integer :cim_id
      t.column :data, :oid,  null: false
      t.string :filename
      t.timestamps
    end
  end
end
