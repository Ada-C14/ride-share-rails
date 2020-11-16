class RemoveColumn < ActiveRecord::Migration[6.0]
  def change
    remove_column :trips, :ride_id
    remove_column :drivers, :ride_id
    remove_column :passengers, :ride_id
  end
end
