class CreateCims < ActiveRecord::Migration[5.0]
  def change
    create_table :cims do |t|
      t.string :slug
      t.string :name
      t.timestamps
    end
  end
end
