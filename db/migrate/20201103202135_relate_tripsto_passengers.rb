class RelateTripstoPassengers < ActiveRecord::Migration[6.0]
  def change
    remove_column :trips, :passenger_id, type: integer
    add_reference :trips, :passenger_id, index: true

  end
end
