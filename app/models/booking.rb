class Booking < ApplicationRecord
  #relations
  belongs_to :parking_slot
  belongs_to :vehicle
  belongs_to :user
  has_one :payment, dependent: :destroy

  #validate
  validates_presence_of :startTime, :endTime

  enum status: {
    'Pending': 0,
    confirmed: 1,
    'Checkin': 2,
    'Checkout': 3,
    cancelled: 4,
  }

  def duration
    return 0 unless startTime && endTime
    (( endTime - startTime ) / 60).to_i
  end
end
