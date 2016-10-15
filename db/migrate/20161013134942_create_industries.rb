class CreateIndustries < ActiveRecord::Migration[5.0]
  def change
    create_table :industries do |t|
      t.string :code
      t.string :name
      t.timestamps
    end
    add_index(:industries, :code)
  end
end
