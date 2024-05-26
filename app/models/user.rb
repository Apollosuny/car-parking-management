class User < ApplicationRecord
  has_person_name
  has_one :profile, dependent: :destroy
  has_many :vehicle, dependent: :destroy
  has_many :booking, dependent: :destroy

  # validate data
  validates :username, presence: true, uniqueness: true

  after_create :init_profile

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  enum :role, [ :user, :admin ]
  after_initialize :set_default_role, :if => :new_record?

  # Helper func
  private 

  def init_profile
    Profile.create(user: self)
  end

  def set_default_role
    self.role ||= :user
  end

end
