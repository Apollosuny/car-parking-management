class Payment < ApplicationRecord
    has_one :booking
    belongs_to :payment_type, optional: true
end
