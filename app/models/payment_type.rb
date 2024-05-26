class PaymentType < ApplicationRecord
    has_many :payments, dependent: :destroy
end
