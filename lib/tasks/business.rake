require 'csv'

desc 'clean up geos'

task cleanup_geos: :environment do
 ActiveRecord::Base.connection.execute("update businesses set country = rtrim(country)")
 ActiveRecord::Base.connection.execute("update businesses set country = ltrim(country)")
 Business.all.each { |business| business.set_geo(force: true) }     
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
  Business.where(geo_id: 151).each {|business| business.set_geo(force: true) }
  user = User.create(email: "no@email.com", password: "Valitaritemp1!",  password_confirmation: "Valitaritemp1!", first_name: "System", last_name: "User") 
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
      last_updated_by_id: user.id)
   end

   a = ["  Arizona",  " Alabama", " Alabama ", " Alaska", " Alaska ", " Alberta", " Alberta ", " Arizona", " Arizona ", " Arkansas", " Arkansas ", " British Columbi", " British Columbia", " British Columbia ", " Californi", " California", " California ", " Colorado", " Colorado ", " Connecticut", " Connecticut ", " Delaware", " Delaware ", " District Of Columbia", " District Of Columbia ", " Florid", " Florida", " Florida ", " Florida 33406", " Georgia", " Georgia ", " Guam", " Hawaii", " Hawaii ", " Idaho", " Idaho ", " Illinois", " Illinois ", " Illinois  ", " Indiana", " Indiana ", " Indiana 47851", " Iowa", " Iowa ", " Kansas", " Kansas ", " Kentucky", " Kentucky ", " Louisiana", " Louisiana ", " Maine", " Maine ", " Manitoba", " Manitoba ", " Marshall Islands", " Maryland", " Maryland ", " Massachusett", " Massachusetts", " Massachusetts ", " Michigan", " Michigan ", " Michigan  ", " Minnesot", " Minnesota", " Minnesota ", " Minnesota D300", " Mississippi", " Mississippi ", " Missouri", " Missouri ", " Montana", " Montana ", " Nebraska", " Nebraska ", " Nevada", " Nevada ", " New Brunswick", " New Brunswick ", " New Hampshire", " New Hampshire ", " New Jersey", " New Jersey ", " New Jersey  ", " New Mexico", " New Mexico ", " New York", " New York ", " Newfoundland and Labrador", " Newfoundland and Labrador ", " Newfoundland and Labrador  ", " North Carolina", " North Carolina ", " North Dakota", " North Dakota ", " Northern Mariana Islands", " Northwest Territories", " Northwest Territories ", " Nova Scotia", " Nova Scotia ", " Nunavut", " Ohio", " Ohio ", " Oklahoma", " Oklahoma ", " Ontario", " Ontario ", " Ontario  ", " Oregon", " Oregon ", " Pennsylvani", " Pennsylvania", " Pennsylvania ", " Prince Edward Island", " Prince Edward Island ", " Puerto Rico", " Puerto Rico ", " Quebec", " Quebec ", " Rhode Island", " Rhode Island ", " Saskatchewan", " Saskatchewan ", " South Carolina", " South Carolina ", " South Dakota", " South Dakota ", " Tennessee", " Tennessee ", " Texa", " Texas", " Texas ", " Utah", " Utah ", " Vermont", " Vermont ", " Virginia", " Virginia ", " Washington", " Washington ", " West Virginia", " West Virginia ", " WestVirginia", " Wisconsin", " Wisconsin ", " Wyoming", " Wyoming ", " Yukon Territory", "-", "8053", "AK", "AL", "AR", "AZ", "Alabama", "Alabama ", "Alaska", "Alberta", "Alberta ", "Albuquerque", "Anderson", "Arizona", "Arizona ", "Arkansas", "British Columbia", "British Columbia ", "Buena Park", "CA", "CO", "CT", "California", "California ", "California 94551", "Carolina", "Charleston", "Cheraw", "Colorado", "Colorado ", "Connecticut", "Connecticut ", "DC", "DE", "Delaware", "Delaware ", "District  Of Columbia", "District Of Columbia", "FL", "Federated States Of Micronesia", "Florida", "Florida ", "GA", "Georgia", "Georgia ", "Guam", "HI", "Happy Valley-Goose Bay ", "Hawaii", "Houghton", "IA", "ID", "IL", "IN", "Idaho", "Illinois", "Illinois ", "Indiana", "Indiana ", "Iowa", "Iowa ", "KS", "KY"]
    b = ["Kansas", "Kentucky", "Kentucky ", "LA", "Louisiana", "Louisiana ", "MA", "MD", "ME", "MI", "MN", "MO", "MS", "MT", "Maine", "Maine ", "Majuro", "Manitoba", "Manitoba ", "Maryland", "Maryland ", "Massachusetts", "Massachusetts ", "Massachussets", "Michigan", "Michigan ", "Minnesota", "Minnesota ", "Mississippi", "Mississippi ", "Missouri", "Missouri ", "Montana", "NC", "ND", "NE", "NH", "NJ", "NM", "NV", "NY", "Nebraska", "Nevada", "Nevada ", "New", "New Brunswick", "New Hampshire", "New Jersey", "New Jersey ", "New Mexico", "New York", "New York ", "New York  ", "Newfoundland and Labrador", "Newfoundland and Labrador ", "North Carolina", "North Carolina ", "North Dakota", "North Dakota ", "Northwest Territories", "Nova Scotia", "Nova Scotia ", "Nunavut", "OH", "OK", "OR", "Ohio", "Ohio ", "Oklahoma", "Oklahoma ", "Ontario", "Ontario ", "Ontario,", "Oregon", "PA", "PR", "Pennsylvania", "Pennsylvania ", "Prince Edward Island", "Prince Edward Island ", "Puerto Rico", "Puerto Rico ", "Quebec", "Quebec ", "RI", "Raleigh", "Rhode Island", "SC", "SD", "Saskatchewan", "Saskatchewan ", "South Carolina", "South Carolinac", "South Dakota", "TX", "Tennessee", "Tennessee ", "Texas", "Texas ", "UT", "Utah", "VA", "VI", "VT", "Vermont", "Virgin Islands", "Virginia", "WA", "WI", "WV", "WY", "Washington", "Washington ", "West Virginia", "West Virginia ", "Wheaton", "Wilmington", "Wisconsin", "Wyoming", "Wyoming ", "Yukon Territory"]
    [a + b].flatten.each do |state|
       if state.length == 2
         full_state = Geo.state_abbrev_map[state.to_sym]
         Business.where(state: state).update_all(state: full_state)
       else
         Business.where(state: state).update_all(state: state.strip)
       end
      { " - "              => "Newfoundland and Labrador",
        "8053"             => "New Jersey",
        "British Columbi"  => "British Columbia", 
        "Californi"        => "Californi", 
        "California 94551" => "California", 
        "Florid"           => "Florida", 
        "Florida 33406"    => "Florida", 
        "Indiana 47851"    => "Indiana", 
        "Massachusett"     => "Massachusetts", 
        "Minnesot"         => "Minnesota", 
        "Minnesota D300"   => "Minnesota", 
        "New"              => "New York", 
        "Ontario,"         => "Ontario,", 
        "Texa"             => "Texas", 
        "WestVirginia"     => "West Virginia" }.each do |wrong, right|
          p Business.where(state: wrong).update_all(state: right) 
      end
  end
  ["Headquarters\rUnited States", "Headquarters\rCanada"].each do |a|
    Business.where(address: a).update_all(address: a.split("\r").reverse.join(' ') )
 end
 ActiveRecord::Base.connection.execute("update businesses set postal_code = concat('0' || postal_code) where length(postal_code) = 4 ")
 Business.update_all(duplication_status: Business::DUPLICATION_STATUS_READY )
end 

