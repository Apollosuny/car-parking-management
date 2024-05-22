class Vehicle < ApplicationRecord
  belongs_to :vehicle_model
  belongs_to :user
  has_many :booking

  has_one_attached :image
end
