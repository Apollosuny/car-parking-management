class User < ApplicationRecord
  has_person_name
  has_one :profile
  has_many :vehicle
  has_many :booking

  # validate data
  validates :username, presence: true, uniqueness: true

  after_create :init_profile

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # Helper func
  private 

  def init_profile
    Profile.create(user: self)
  end

end
