class AddCompleteToTrips < ActiveRecord::Migration[6.0]
  def change
    add_column :trips, :complete, :boolean, default: true
  end
end
