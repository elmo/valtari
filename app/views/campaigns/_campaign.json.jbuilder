json.extract! campaign, :id, :title, :revenue, :ebitda, :industry_id, :created_at, :updated_at
json.url campaign_url(campaign, format: :json)