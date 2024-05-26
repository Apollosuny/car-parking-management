class VehicleModel < ApplicationRecord
    has_many :vehicle, dependent: :destroy

    searchkick text_middle: %i[brand]
end
