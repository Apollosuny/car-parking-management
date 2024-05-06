class CreateVehicles < ActiveRecord::Migration[7.0]
  def change
    create_table :vehicles do |t|
      t.belongs_to :vehicle_model, null: false, foreign_key: true
      t.belongs_to :user, null: false, foreign_key: true
      t.string :vehicleRegistrationPlate
      t.text :description
      t.boolean :status

      t.timestamps
    end
  end
end
