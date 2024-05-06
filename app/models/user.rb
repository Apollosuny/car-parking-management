class User < ApplicationRecord
  has_person_name
  has_one :profile
  has_many :vehicle
  has_many :booking

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
