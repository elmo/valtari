require 'csv'
class Business < ApplicationRecord
  belongs_to :geo, optional: true
  before_validation :set_geo
  has_many :notes, as: :notable

  scope :within_division1, -> (division1) { where(division1: division1) }
  scope :within_division2, -> (division2) { where(division2: division2) }
  scope :within_division3, -> (division3) { where(division3: division3) }
  scope :within_division4, -> (division4) { where(division4: division4) }
  scope :within_division5, -> (division5) { where(division4: division5) }
  belongs_to :last_updated_by_user, class_name: 'User', foreign_key: :last_updated_by_id, optional: :true

  DUPLICATION_STATUS_READY = "ready"
  DUPLICATION_STATUS_DUPE = "dupe"
  DUPLICATION_STATUS_OK = "ok"

  scope :ready, -> {where(duplication_status: DUPLICATION_STATUS_READY) }
  scope :dupe, -> {where(duplication_status: DUPLICATION_STATUS_DUPE) }
  scope :ok, -> {where(duplication_status: DUPLICATION_STATUS_OK) }

  def new!(user:)
    update_attributes(duplication_status: DUPLICATION_STATUS_READY, last_updated_by_id: user.id)
  end

  def dupe!(user:)
    update_attributes(duplication_status: DUPLICATION_STATUS_DUPE, last_updated_by_id: user.id)
  end

  def undupe!(user:)
    update_attributes(duplication_status: DUPLICATION_STATUS_OK, last_updated_by_id: user.id)
  end

  def dupe?
    duplication_status == DUPLICATION_STATUS_DUPE
  end

  def ok?
    duplication_status == DUPLICATION_STATUS_OK
  end

  def ready?
    duplication_status == DUPLICATION_STATUS_READY
  end

  def set_geo
    if geo.blank?
      self.geo = Geo.for_state_abbreviation(state)
      return if self.geo.nil?
      self.division1 = geo.division1 if geo.division1.present?
      self.division2 = geo.division2 if geo.division2.present?
      self.division3 = geo.division3 if geo.division3.present?
      self.division4 = geo.division4 if geo.division4.present?
      self.division5 = geo.division5 if geo.division5.present?
    end
  end

  def self.set_divisions
    Business.joins(:geo).each do |business|
      business.division1 = business.geo.division1 if business.geo.division1.present?
      business.division2 = business.geo.division2 if business.geo.division2.present?
      business.division3 = business.geo.division3 if business.geo.division3.present?
      business.division4 = business.geo.division4 if business.geo.division4.present?
      business.division5 = businessegeo.division5 if business.geo.division5.present?
      business.save
    end
  end

  def title
    company_name
  end

  def self.countries
     ["United States", "Canada", "Federated States Of Micronesia"]
  end

  def self.states
    ["AK", "AL", "AR", "AZ", "Alabama", "Alaska", "Alberta", "Arizona", "Arkansas", "British Columbia", "CA", "CO", "CT", "California", "Colorado", "Connecticut", "DC", "DE", "Delaware", "District Of Columbia", "FL", "Federated States Of Micronesia", "Florida", "GA", "Georgia", "Guam", "HI", "Hawaii", "IA", "ID", "IL", "IN", "Idaho", "Illinois", "Indiana", "Iowa", "KS", "KY", "Kansas", "Kentucky", "LA", "Louisiana", "MA", "MD", "ME", "MI", "MN", "MO", "MS", "MT", "Maine", "Manitoba", "Marshall Islands", "Maryland", "Massachusetts", "Michigan", "Minnesota", "Mississippi", "Missouri", "Montana", "NC", "ND", "NE", "NH", "NJ", "NM", "NV", "NY", "Nebraska", "Nevada", "New Brunswick", "New Hampshire", "New Jersey", "New Mexico", "New York", "Newfoundland and Labrador", "North Carolina", "North Dakota", "Northern Mariana Islands", "Northwest Territories", "Nova Scotia", "Nunavut", "OH", "OK", "OR", "Ohio", "Oklahoma", "Ontario", "Oregon", "PA", "PR", "Pennsylvania", "Prince Edward Island", "Puerto Rico", "Quebec", "RI", "Rhode Island", "SC", "SD", "Saskatchewan", "South Carolina", "South Dakota", "TX", "Tennessee", "Texas", "UT", "Utah", "VA", "VI", "VT", "Vermont", "Virgin Islands", "Virginia", "WA", "WI", "WV", "WY", "Washington", "West Virginia", "Wisconsin", "Wyoming", "Yukon Territory"]
  end


  def self.clean_addresses
     city, state, country, phone = '','','','',''
     h = {}
     (2..10).each { |i| h[i] = [] }
     one,two,three,four,five,six,seven,eight,nine,ten = 0,0,0,0,0,0,0,0,0,0
     Business.where(["address like ? ", "Headquarters%" ]).each do |business|
      a = business.address.split("\r")
      a.each do |x|
       x.squeeze!(" ")
      end
      y = a.shift
      a.unshift(business.id)
      h[a.size] << a
    end
     h.keys.each do |key|
       write_file(key, h[key])
     end
  end

  def self.write_file(key,rows)
    CSV.open("db/#{key}_columns.csv", 'w') do |csv|
      rows.each { |row| csv << row.flatten }
    end
  end

  def self.parse_type_three(a)
      x = a.first
      y = a.last
      if !countries.include?(y)
        phone = x.gsub(/\D/, '') if x =~ /hone/
        if countries.include?(x)
          country = x
        end
      else
        country = y
      end
     if states.include?(x)
       city,state,zip = nil,x, nil
     elsif countries.include?(x)
     elsif  m = x.match(/(.*), (.*)    (\d\d\d\d\d)$/)
       city,state,zip = m[1],m[2],m[3]
     elsif m = x.match(/(.*), (.*)    (\d\d\d\d\d-\d\d\d\d)$/)
       city,state,zip = m[1],m[2],m[3]
     elsif m = x.match(/(.*)    (\w\w\w \w\w\w)$/)
       city,state,zip = m[1],m[2],m[3]
     elsif m = x.match(/(.*), (.*)\s+(\d+)/)
       city,state,zip = m[1],m[2],m[3]
     elsif m = x.match(/(.*), (.*)/)
       city,state,zip = m[1],m[2], nil
     end
     return city,state,country,zip
  end

  def self.parse_type_four(a)
    address = a.shift
    if  a[0] =~ /suite|unit|floor|bldg/i
      address += " #{a.shift}"
    end

    if a[0].blank?
      a.shift
    end

    x = a[0]
    x.strip!
    x.squeeze!(' ')
    if  m = x.match(/(.*), (.*)\s+(\d\d\d\d\d)$/)
      city,state,zip = m[1],m[2],m[3]
    elsif m = x.match(/(.*), (.*)\s+(\d\d\d\d\d-\d\d\d\d)$/)
      city,state,zip = m[1],m[2],m[3]
    elsif m = x.match(/(.*)\s+(\w\w\w \w\w\w)$/)
      city,state,zip = m[1],m[2],m[3]
    elsif m = x.match(/(.*), (.*)\s+(\d+)/)
      city,state,zip = m[1],m[2],m[3]
    elsif m = x.match(/(.*), (.*) (\w\w\w\w\w\w)$/)
      city,state,zip = m[1],m[2],m[3]
    else
       country = a.last
    end
    return  address, city, state, counrty, zip, phone
  end

  def self.clean_street_address(address)
      address.strip!
      if m = address.match(/(.*), (.*)    (\d\d\d\d\d)$/)
       city,state,zip = m[1],m[2],m[3]
       return nil,city,state,zip
      elsif m = address.match(/(.*), (.*)    (\d\d\d\d\d-\d\d\d\d)$/)
         city,state,zip = m[1],m[2],m[3]
       return nil, city,state,zip
      elsif m = address.match(/,/)
        return address, nil,nil,nil
     end
  end

end
