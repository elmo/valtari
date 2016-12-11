module GeosHelper

  def division1_names
    Geo.select(:division1).distinct.collect(&:division1)
  end

  def names_within_division1(division1_name)
    Geo.within_division1(division1_name).collect(&:division2)
  end

  def names_within_division2(division2_name)
    Geo.within_division2(division2_name).collect(&:division3)
  end

  def names_within_division3(division3_name)
    Geo.within_division3(division3_name).collect(&:division4)
  end

  def names_within_division4(division4_name)
    Geo.within_division4(division4_name).collect(&:division5)
  end

  def state_abbrev_map
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
      VI: "Virgin Islands",
      VT: "Vermont",
      WA: "Washington",
      WI: "Wisconsin",
      WV: "West Virginia",
      WY: "Wyoming",
      MP: "Northern Mariana Islands",
      FM: "Federated States of Micronesia",
      MH: "Marshall Islands",
      PW: "Palau"
    }
  end
end
