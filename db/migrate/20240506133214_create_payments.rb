class CreatePayments < ActiveRecord::Migration[7.0]
  def change
    create_table :payments do |t|
      t.float :totalTime
      t.string :paymentType
      t.text :note
      t.boolean :status

      t.timestamps
    end
  end
end
