json.extract! campaign, :id, :title, :revenue_lower, :revenue_upper, :ebitda_lower, :ebitda_upper, :industry_id, :stage, :created_at, :updated_at
json.url campaign_url(campaign, format: :json)
