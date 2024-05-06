class CreateBookings < ActiveRecord::Migration[7.0]
  def change
    create_table :bookings do |t|
      t.belongs_to :parking_slot, null: false, foreign_key: true
      t.belongs_to :vehicle, null: false, foreign_key: true
      t.belongs_to :user, null: false, foreign_key: true
      t.datetime :startTime
      t.datetime :endTime
      t.boolean :status

      t.timestamps
    end
  end
end
