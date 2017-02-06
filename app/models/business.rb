class Business < ApplicationRecord
  belongs_to :geo, optional: true
  before_validation :set_geo
  has_many :notes, as: :notable

  scope :within_division1, -> (division1) { where(division1: division1) }
  scope :within_division2, -> (division2) { where(division2: division2) }
  scope :within_division3, -> (division3) { where(division3: division3) }
  scope :within_division4, -> (division4) { where(division4: division4) }
  scope :within_division5, -> (division5) { where(division4: division5) }
  belongs_to :last_updated_by_user, class_name: 'User', foreign_key: :last_updated_by_id

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

end
