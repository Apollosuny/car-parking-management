class AddPriceToParkingSlots < ActiveRecord::Migration[7.0]
  def change
    add_column :parking_slots, :price, :float
  end
end
