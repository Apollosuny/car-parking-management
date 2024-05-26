class Payment < ApplicationRecord
    has_one :booking, dependent: :destroy
    belongs_to :payment_type, optional: true
end
