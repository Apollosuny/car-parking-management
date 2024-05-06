class CreateParkingSlots < ActiveRecord::Migration[7.0]
  def change
    create_table :parking_slots do |t|
      t.integer :slotNumber
      t.boolean :status

      t.timestamps
    end
  end
end
