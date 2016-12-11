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

end
