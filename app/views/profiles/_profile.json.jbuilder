json.extract! profile, :id, :fullName, :avatar, :phone, :user_id, :created_at, :updated_at
json.url profile_url(profile, format: :json)
