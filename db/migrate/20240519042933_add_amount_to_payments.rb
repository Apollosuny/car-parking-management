class AddAmountToPayments < ActiveRecord::Migration[7.0]
  def change
    add_column :payments, :totalPrice, :float
  end
end
