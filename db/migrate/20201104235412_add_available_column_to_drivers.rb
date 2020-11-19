class AddAvailableColumnToDrivers < ActiveRecord::Migration[6.0]
  def change
    add_column :drivers, :available, :boolean, default: true
  end
end
