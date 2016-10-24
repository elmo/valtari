require 'csv'

task load_naic_codes: :environment do
  CSV.foreach('db/industries.csv').with_index do |row,i|
    next if i == 0
    Industry.create!( code: row[0] ,name: row[1] )
  end
end
