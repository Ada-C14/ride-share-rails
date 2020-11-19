class CreateTrips < ActiveRecord::Migration[6.0]
  def change
    create_table :trips do |t|
      t.integer :passenger_id
      t.string :start_time
      t.string :end_time
      t.float :cost
      t.float :rating
      t.integer :driver_id

      t.timestamps
    end
  end
end
