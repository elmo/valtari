class Geo < ApplicationRecord
  scope :within_division1, -> (division1) { where(division1: division1).where("division2 is not null and division3 is null and division4 is null and division5 is null") }
  scope :within_division2, -> (division2) { where(division2: division2).where("division3 is not null and division4 is null and division5 is null") }
  scope :within_division3, -> (division3) { where(division3: division3).where("division4 is not null and division5 is null") }
  scope :within_division4, -> (division4) { where(division4: division4).where("division5 is not null") }
  scope :without_division5, -> { where( division5: nil) }

  def parent_geo
    return Geo.where(division4: division4).where(division5: nil).first if division5.present?
    return Geo.where(division3: division3).where(division4: nil).first if division4.present?
    return Geo.where(division2: division3).where(division3: nil).first if division3.present?
    return Geo.where(division1: division2).where(division2: nil).first if division2.present?
    nil
  end

  def parents
    a = []
    child = self
    while true
      parent = child.parent_geo
      return a if parent.nil?
      a << parent
      child = parent
    end
  end

  def self.division1
    Geo.select(:division1).distinct
  end

  def self.for_state_abbreviation(state_abbreviation)
      return if state_abbreviation.nil?
    full_state_name = Geo.state_abbrev_map[state_abbreviation.to_sym]
    return nil if full_state_name.nil?
    if full_state_name == 'Georgia'
      Geo.where(division4: full_state_name)[1]
    else
      Geo.where(division4: full_state_name).without_division5.first
    end
  end

  def zone4_abbreviation
    Geo::state_abbrev_map.invert[division4].to_s
  end


  def self.geo_code_canada
    Business.within_country('Canada').where(state: canadian_provences).each {|business| process_canadian(business: business) }
    nil
  end

  def self.process_canadian(business:)
      geo = Geo.where(division2: 'Canada',  division3: business.state).first
      return if geo.nil?
      business.geo = geo
      business.division1 = business.geo.division1 if business.geo.division1.present?
      business.division2 = business.geo.division2 if business.geo.division2.present?
      business.division3 = business.geo.division3 if business.geo.division3.present?
      business.division4 = business.geo.division4 if business.geo.division4.present?
      business.division5 = businessegeo.division5 if business.geo.division5.present?
      business.save
  end

  def self.canadian_provences
     [
       "Alberta", "British Columbia", "Manitoba", "New Brunswick", "Newfoundland and Labrador",
       "Northwest Territories", "Nova Scotia", "Nunavut", "Ontario", "Prince Edward Island",
       "Quebec", "Saskatchewan", "Yukon Territory"
     ]
  end


  def self.state_abbrev_map
    {
      AK: "Alaska",
      AL: "Alabama",
      AR: "Arkansas",
      AS: "American Samoa",
      AZ: "Arizona",
      CA: "California",
      CO: "Colorado",
      CT: "Connecticut",
      DC: "Washington, D. C.",
      DE: "Delaware",
      FL: "Florida",
      GA: "Georgia",
      GU: "Guam",
      HI: "Hawaii",
      IA: "Iowa",
      ID: "Idaho",
      IL: "Illinois",
      IN: "Indiana",
      KS: "Kansas",
      KY: "Kentucky",
      LA: "Louisiana",
      MA: "Massachusetts",
      MD: "Maryland",
      ME: "Maine",
      MI: "Michigan",
      MN: "Minnesota",
      MO: "Missouri",
      MS: "Mississippi",
      MT: "Montana",
      NC: "North Carolina",
      ND: "North Dakota",
      NE: "Nebraska",
      NH: "New Hampshire",
      NJ: "New Jersey",
      NM: "New Mexico",
      NV: "Nevada",
      NY: "New York",
      OH: "Ohio",
      OK: "Oklahoma",
      OR: "Oregon",
      PA: "Pennsylvania",
      PR: "Puerto Rico",
      RI: "Rhode Island",
      SC: "South Carolina",
      SD: "South Dakota",
      TN: "Tennessee",
      TX: "Texas",
      UT: "Utah",
      VA: "Virginia",
      VI: "U.S. Virgin Islands",
      VT: "Vermont",
      WA: "Washington",
      WI: "Wisconsin",
      WV: "West Virginia",
      WY: "Wyoming",
      MP: "Northern Mariana Islands",
      FM: "Micronesia, Federated States of ",
      MH: "Marshall Islands",
      PW: "Palau"
    }
  end

end
