json.extract! booking, :id, :parking_slot_id, :vehicle_id, :user_id, :startTime, :endTime, :status, :created_at, :updated_at
json.url booking_url(booking, format: :json)
