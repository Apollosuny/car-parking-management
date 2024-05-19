class AddPaymentTypeToPayments < ActiveRecord::Migration[7.0]
  def change
    add_reference :payments, :payment_type, null: true, foreign_key: true
  end
end
