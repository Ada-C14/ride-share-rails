class ChangeTimesTrips < ActiveRecord::Migration[6.0]
  def change
    remove_column :trips, :start_time
    remove_column :trips, :end_time
    add_column :trips, :date, :datetime
    add_column :trips, :end_time, :datetime
  end
end
