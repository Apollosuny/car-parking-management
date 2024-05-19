class AddPaymentTypesIdToPayment < ActiveRecord::Migration[7.0]
  def change
    add_column :payments, :payment_type_id, :integer
  end
end
