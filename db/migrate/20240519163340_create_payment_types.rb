class CreatePaymentTypes < ActiveRecord::Migration[7.0]
  def change
    create_table :payment_types do |t|
      t.string :name
      t.text :description
      t.string :code
      t.boolean :active

      t.timestamps
    end
  end
end
