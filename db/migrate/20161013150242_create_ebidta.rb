class CreateEbidta < ActiveRecord::Migration[5.0]
  def change
    create_table :ebidta do |t|
      t.string :name

      t.timestamps
    end
  end
end
