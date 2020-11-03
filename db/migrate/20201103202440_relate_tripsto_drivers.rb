class RelateTripstoDrivers < ActiveRecord::Migration[6.0]
  def change
    remove_column :trips, :driver_id, type: Integer
    add_reference :trips, :driver_id, index: true

  end
end
