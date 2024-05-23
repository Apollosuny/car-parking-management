class VehicleModel < ApplicationRecord
    has_many :vehicle
    searchkick
end
