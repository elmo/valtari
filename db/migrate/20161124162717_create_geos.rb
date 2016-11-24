class CreateGeos < ActiveRecord::Migration[5.0]
  def change
    create_table :geos do |t|
      t.string :division1
      t.string :division2
      t.string :division3
      t.string :division4
      t.string :division5
      t.timestamps
    end
    CSV.foreach('db/geos.csv').with_index do |row,i|
      Geo.create!( division1: row[0], division2: row[1], division3: row[2], division4: row[3], division5: row[4] )
    end
  end
end
