require 'csv'
class Business < ApplicationRecord
  has_logidze
  belongs_to :geo, optional: true
  before_validation :set_geo
  has_many :notes, as: :notable
  after_update :log_changes

  scope :within_division1, -> (division1) { where(division1: division1) }
  scope :within_division2, -> (division2) { where(division2: division2) }
  scope :within_division3, -> (division3) { where(division3: division3) }
  scope :within_division4, -> (division4) { where(division4: division4) }
  scope :within_division5, -> (division5) { where(division4: division5) }
  scope :matching_company, -> (company_name) { where(["lower(company_name) like ? ", '%' + company_name.downcase + '%'] ) }
  scope :within_city, -> (city) { where(["lower(city) like ? ", '%' + city.downcase + '%'] ) }
  scope :within_state, -> (state) { where(["lower(state) like ? ", '%' + state.downcase + '%'] ) }
  scope :within_country, -> (country) { where(["lower(country) like ? ", '%' + country.downcase + '%'] ) }
  scope :within_postal_code, -> (postal_code) { where(["lower(postal_code) like ? ", '%' + postal_code.downcase + '%'] ) }

  scope :with_email, -> { where("email is not null and email != '' ") }
  scope :with_phone, -> { where("phone is not null and phone != '' ") }
  scope :with_address, -> { where("address is not null and address != '' ") }
  scope :with_city, -> { where("city is not null and city != '' ") }
  scope :with_state, -> { where("state is not null and  state != '' ") }
  scope :with_country, -> { where("country is not null or country != '' ") }
  scope :with_contact_first_name, -> { where("contact_first_name is not null and contact_first_name != '' ") }
  scope :with_contact_last_name, -> { where("contact_first_name is not null and contact_last_name != '' ") }
  scope :with_contact_title, -> { where("contact_title is not null and  contact_title != '' ") }
  scope :with_website, -> { where("website is not null and  website != '' ") }
  scope :with_revenue , -> { where("revenue is not null") }
  scope :with_number_of_employees, -> { where("number_of_employees is not null") }
  scope :with_naics_code, -> { where("naics_code is not null and  naics_code != '' ") }
  scope :with_sic_code, -> { where("sic_code is not null and  sic_code != '' " ) }
  scope :with_parent_company, -> { where("parent_company is not null and parent_company != '' " ) }
  scope :with_geo_id, -> { where("geo_id is not null") }
  scope :with_division1, -> { where("division1 is not null and division1 != '' " ) }
  scope :with_division2, -> { where("division2 is not null and division2 != '' " ) }
  scope :with_division3, -> { where("division3 is not null and division3 != '' " ) }
  scope :with_division4, -> { where("division4 is not null and division4 != '' " ) }
  scope :with_division5, -> { where("division5 is not null and division5 != '' " ) }
  scope :with_duplication_status, -> { where("duplication_status is not null and duplication_status != '' " ) }

  scope :without_email, -> { where("email is null or email = '' ") }
  scope :without_phone, -> { where("phone is null or phone = '' ") }
  scope :without_address, -> { where("address is null or address = '' ") }
  scope :without_city, -> { where("city is null or city = '' ") }
  scope :without_state, -> { where("state is null or state = '' ") }
  scope :without_country, -> { where("country is null or country = '' ") }
  scope :without_contact_first_name, -> { where("contact_first_name is null or contact_first_name = '' ") }
  scope :without_contact_last_name, -> { where("contact_first_name is null or contact_last_name = '' ") }
  scope :without_contact_title, -> { where("contact_title is null or contact_title = '' ") }
  scope :without_website, -> { where("website is null or website = '' ") }
  scope :without_revenue , -> { where("revenue is null") }
  scope :without_number_of_employees, -> { where("number_of_employees is null") }
  scope :without_naics_code, -> { where("naics_code is null or naics_code = '' ") }
  scope :without_sic_code, -> { where("sic_code is null or sic_code = '' " ) }
  scope :without_parent_company, -> { where("parent_company is null or parent_company = '' " ) }
  scope :without_geo_id, -> { where( geo_id: nil) }
  scope :without_division1, -> { where("division1 is null or division1 = '' " ) }
  scope :without_division2, -> { where("division2 is null or division2 = '' " ) }
  scope :without_division3, -> { where("division3 is null or division3 = '' " ) }
  scope :without_division4, -> { where("division4 is null or division4 = '' " ) }
  scope :without_division5, -> { where("division5 is null or division5 = '' " ) }
  scope :without_duplication_status, -> { where("duplication_status is null or duplication_status = '' " ) }

  belongs_to :last_updated_by_user, class_name: 'User', foreign_key: :last_updated_by_id, optional: true

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

  def set_geo(force: false)
    user = User.with_role(:admin).first
    if force or geo.blank?
      self.geo = Geo.for_state_abbreviation(state)
      return if self.geo.nil?
      self.division1 = geo.division1 if force or geo.division1.present?
      self.division2 = geo.division2 if force or geo.division2.present?
      self.division3 = geo.division3 if force or geo.division3.present?
      self.division4 = geo.division4 if force or geo.division4.present?
      self.division5 = geo.division5 if force or geo.division5.present?
      if force
        self.last_updated_by_user = user
        self.save
      end
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

  def self.to_csv
    attributes = [
      "id", "company_name", "contact_first_name", "contact_last_name", "contact_title",
      "phone", "email", "website", "revenue", "number_of_employees", "naics_code",
      "sic_code", "industry_classification", "description", "address", "city", "state",
      "country", "postal_code", "status", "parent_company", "geo_id", "division1",
      "division2", "division3", "division4", "division5", "duplication_status",
    ]
    CSV.generate(headers: true) do |csv|
      csv << attributes
      all.each do |business|
        csv << attributes.map{ |attr| business.send(attr)}
      end
    end
  end

  private

  def log_changes
    if last_updated_by_id.present?
      action = self.changes
      action.delete("created_at")
      action.delete("updated_at")
      ActivityLog.create(user: User.find(last_updated_by_id) , business: self, action: action )
    end
  end

end
