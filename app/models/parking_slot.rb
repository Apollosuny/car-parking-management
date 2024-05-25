class ParkingSlot < ApplicationRecord
    #relations
    has_many :booking, dependent: :destroy

    #validates
    validates :price, presence: true
end
