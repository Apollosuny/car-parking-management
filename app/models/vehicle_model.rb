class VehicleModel < ApplicationRecord
    has_many :vehicle

    searchkick text_middle: %i[brand]
end
