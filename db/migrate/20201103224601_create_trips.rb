class CreateTrips < ActiveRecord::Migration[6.0]
  def change
    create_table :trips do |t|
      t.integer :trip_id
      t.integer :driver_id
      t.integer :passenger_id
      t.string :date
      t.string :rating
      t.float :cost

      t.timestamps
    end
  end
end
