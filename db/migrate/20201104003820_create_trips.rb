class CreateTrips < ActiveRecord::Migration[6.0]
  def change
    create_table :trips do |t|
      t.string :driver_id
      t.string :passenger_id
      t.string :date
      t.string :rating
      t.string :cost

      t.timestamps
    end
  end
end
