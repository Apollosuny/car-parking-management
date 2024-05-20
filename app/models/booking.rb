class Booking < ApplicationRecord
  belongs_to :parking_slot
  belongs_to :vehicle
  belongs_to :user
  has_one :payment, dependent: :destroy

  enum status: {
    pending: 0,
    confirmed: 1,
    checked_in: 2,
    checked_out: 3,
    cancelled: 4,
  }

  def duration
    return 0 unless startTime && endTime
    (( endTime - startTime ) / 60).to_i
  end
end
