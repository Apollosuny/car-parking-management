json.extract! payment, :id, :totalTime, :paymentType, :note, :status, :created_at, :updated_at
json.url payment_url(payment, format: :json)
