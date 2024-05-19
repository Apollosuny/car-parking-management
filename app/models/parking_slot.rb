class ParkingSlot < ApplicationRecord
    has_many :booking, dependent: :destroy

    validates :price, presence: true
end
