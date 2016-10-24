class CreateIndustries < ActiveRecord::Migration[5.0]
  def change
    create_table :industries do |t|
      t.string :code
      t.string :name
      t.timestamps
    end
    add_index(:industries, :code)
    CSV.foreach('db/industries.csv').with_index do |row,i|
      next if i == 0
      Industry.create!( code: row[0] ,name: row[1] )
    end
  end
end
