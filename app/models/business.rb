class Business < ApplicationRecord
  belongs_to :geo, optional: true
  before_validation :set_geo

  def set_geo
    self.geo = Geo.for_state_abbreviation(state) if geo.blank?
  end

end
