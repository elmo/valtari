json.extract! business, :id, :company_name,:contact_first_name,:contact_last_name,:contact_title,:phone,:email,:website,:revenue,:number_of_employees,:naics_code,:sic_code,:industry_classification,:description,:address,:city,:state,:country,:postal_code,:status 
json.url business_url(business, format: :json)
