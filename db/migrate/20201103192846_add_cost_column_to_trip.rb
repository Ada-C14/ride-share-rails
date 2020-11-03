class AddCostColumnToTrip < ActiveRecord::Migration[6.0]
  def change
    add_column :trips, :cost, :integer
  end
end
