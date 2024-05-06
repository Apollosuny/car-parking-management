class CreateVehicleModels < ActiveRecord::Migration[7.0]
  def change
    create_table :vehicle_models do |t|
      t.string :brand
      t.string :model
      t.string :year
      t.string :color
      t.string :bodyType

      t.timestamps
    end
  end
end
