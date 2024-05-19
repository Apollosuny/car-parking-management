class RemoveColumn < ActiveRecord::Migration[7.0]
  def change
    remove_column :payments, :payment_type_id
  end
end
