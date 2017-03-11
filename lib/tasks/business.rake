require 'csv'

desc 'convert business tsv'

task convert_business_tsv: :environment do
  CSV.open('db/full_businesses.csv', 'w') do |csv|
    File.open('db/newfile.tsv') do |f|
      f.each_line do |tsv|
        tsv.chomp!
        csv << tsv.split(/\t/)
      end
    end
  end
end


task load_businesses: :environment do
  UserBusiness.destroy_all
  Business.delete_all
  ActiveRecord::Base.connection.reset_pk_sequence!('businesses')
  CSV.foreach('db/businesses.csv').with_index do |row,i|
    next if i == 0
    name = row[0].split(' ').map {|x| x.capitalize }.join(' ')
    Business.create!(
     company_name: name,
     contact_first_name: row[1],
     contact_last_name:row[2],
     contact_title: row[3],
     email: row[4],
     website: row[5],
     revenue: row[6].to_f,
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

task fix_georgia: :environment do
   Business.where(geo_id: 151).each {|business| business.set_geo(force: true) }
end

task repair_businesses: :environment do
  user = User.first
  CSV.foreach('db/valtari-business-repair.csv').with_index do |row,i|
    next if i == 0
    id,address1, address2,city,state,zip,country,phone1, phone2 = row
    full_address = [address1.try(:strip), address2.try(:strip)].join(' ').strip
    phone =  phone1.gsub(/\D/, '').strip if phone1.present? 
    business =  Business.find(id)
    business.update_attributes( 
      address: full_address, 
      city: city,
      state: state,
      country: country,
      postal_code: zip,
      phone: phone,
      duplication_status: "ready",
      last_updated_by_id: user.id
    )
    p id
  end

end
