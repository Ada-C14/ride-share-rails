class RelateTripsToDrivers < ActiveRecord::Migration[6.0]
  def change
    remove_column :trips, :driver_id
    add_reference :trips, :driver, index: true
  end
end
