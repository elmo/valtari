require 'csv'

desc 'convert business tsv'

task convert_business_tsv: :environment do
  CSV.open('db/businesses.csv', 'w') do |csv|
    File.open('db/businesses.csv.tsv') do |f|
      f.each_line do |tsv|
        tsv.chomp!
        csv << tsv.split(/\t/)
      end
    end
  end
end


task load_businesses: :environment do
  CSV.foreach('db/businesses.csv').with_index do |row,i|
    next if i == 0
    Business.create!(
     company_name: row[0],
     contact_first_name: row[1],
     contact_last_name:row[2],
     contact_title: row[3],
     email: row[4],
     website: row[5],
     revenue: row[6].to_i,
     number_of_employees: row[7].to_i,
     naics_code: row[8],
     sic_code: row[9],
     industry_classification: row[10],
     description: row[11],
     address: row[12],
     city: row[13],
     state: row[14],
     postal_code: row[15],
     country: row[16],
     phone: row[17])
  end
end
