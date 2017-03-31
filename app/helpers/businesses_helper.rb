module BusinessesHelper

  def favorite_business_link(business, remote: true)
    if current_user.favorite_business?(business)
      link_to(my_business_user_business_path(business.id, business.id), method: :delete, remote: remote) do
         content_tag(:div, class: "favorite") do
           ''
         end
      end
    else
      link_to(my_business_user_businesses_path(business.id), method: :post, remote: remote) do
         content_tag(:div, class: "favorite not") do
           ''
         end
      end
    end
  end

  def duplication_statuses
    ['ready', 'ok', 'dupe']
  end

  def business_attributes
    [
      "company_name", "contact_first_name", "contact_last_name", "contact_title",
      "phone", "email", "website", "revenue", "number_of_employees", "naics_code",
      "sic_code", "industry_classification", "description", "address", "city", "state",
      "country", "postal_code", "status", "created_at", "updated_at", "parent_company",
      "geo_id", "division1", "division2", "division3", "division4", "division5",
      "duplication_status", "last_updated_by_id"
    ]
  end


   def with_filters
    [
     :with_email, :with_phone, :with_address, :with_city, :with_state, :with_country,
     :with_contact_first_name, :with_contact_last_name, :with_contact_title, :with_website,
     :with_revenue, :with_number_of_employees, :with_naics_code, :with_sic_code,
     :with_parent_company, :with_geo_id, :with_division1, :with_division2, :with_division3,
     :with_division4, :with_division5
     ]
   end

   def without_filters
    [
     :without_email, :without_phone, :without_address, :without_city,
     :without_state, :without_country, :without_contact_first_name, :without_contact_last_name,
     :without_contact_title, :without_website, :without_revenue, :without_number_of_employees,
     :without_naics_code, :without_sic_code, :without_parent_company,
     :without_geo_id, :without_division1, :without_division2, :without_division3,
     :without_division4, :without_division5
    ]
  end

   def business_search_fields
     [:company_name, :city, :state, :postal_code, :country]
   end

   def business_search_active
      business_search_fields.each do |field|
       return 'active' if params[field].present?
     end
     return ''
   end

  def all_business_scopes
    [with_filters + without_filters].flatten
  end

   def advanced_search_active
     all_business_scopes.each do |field|
       return 'active' if params[field].present?
     end
     return ''
   end

end
