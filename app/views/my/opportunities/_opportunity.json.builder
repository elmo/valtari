json.extract! opportunity, :id, :title, :revenue_amount, :ebitda_amount, :industry_id, :created_at, :updated_at
json.url opportunity_url(opportunity, format: :json)
