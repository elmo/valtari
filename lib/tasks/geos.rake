require 'csv'

task load_geos: :environment do
  CSV.foreach('db/geos.csv').with_index do |row,i|
    Geo.create!( division1: row[0], division2: row[1], division3: row[2], division4: row[3], division5: row[4] )
  end
end
