json.extract! vehicle, :id, :vehicle_model_id, :user_id, :vehicleRegistrationPlate, :description, :status, :created_at, :updated_at, :image
json.url vehicle_url(vehicle, format: :json)
