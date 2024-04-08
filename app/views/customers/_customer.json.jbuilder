json.extract! customer, :id, :name, :phone_number, :dob, :membership, :created_at, :updated_at
json.url customer_url(customer, format: :json)
