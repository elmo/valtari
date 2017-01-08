json.extract! message, :id, :user_id, :recipient_id, :subject, :body, :opened, :created_at, :updated_at
json.url message_url(message, format: :json)
