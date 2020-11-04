class RelateDriversPassengersToTrips < ActiveRecord::Migration[6.0]
  def change
    remove_column :trips, :driver_id
    remove_column :trips, :passenger_id

    add_reference :trips, :driver   #consider using foreign_key
    add_reference :trips, :passenger
  end
end
