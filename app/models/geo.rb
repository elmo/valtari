class Geo < ApplicationRecord
  scope :within_division1, -> (division1) { where(division1: division1) }
  scope :within_division2, -> (division2) { where(division2: division2) }
  scope :within_division3, -> (division3) { where(division3: division3) }
  scope :within_division4, -> (division4) { where(division4: division4) }
  scope :within_division5, -> (division5) { where(division5: division5) }
  scope :without_division5, -> { where(division5: nil) }

  def self.for_state_abbreviation(state_abbreviation)
    full_state_name = Geo.state_abbrev_map[state_abbreviation.to_sym]
    return nil if full_state_name.nil?
    Geo.within_division4(full_state_name).without_division5.first
  end

  def zone4_abbreviation
    Geo::state_abbrev_map.invert[division4].to_s
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
