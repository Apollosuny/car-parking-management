class Booking < ApplicationRecord
  belongs_to :parking_slot
  belongs_to :vehicle
  belongs_to :user
  has_one :payment, dependent: :destroy

  def duration
    return 0 unless startTime && endTime
    (( endTime - startTime ) / 60).to_i
  end
end
