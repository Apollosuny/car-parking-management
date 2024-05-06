class Booking < ApplicationRecord
  belongs_to :parking_slot
  belongs_to :vehicle
  belongs_to :user
  belongs_to :payment
end
