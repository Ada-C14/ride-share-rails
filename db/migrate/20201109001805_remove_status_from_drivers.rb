class RemoveStatusFromDrivers < ActiveRecord::Migration[6.0]
  def change
    remove_column :drivers, :status
  end
end
