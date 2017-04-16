json.extract! cim, :id, :user_id, :slug, :name, :created_at, :updated_at
json.url cim_url(cim, format: :json)