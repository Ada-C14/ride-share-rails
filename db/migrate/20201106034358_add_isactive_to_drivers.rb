class AddIsactiveToDrivers < ActiveRecord::Migration[6.0]
  def change
    add_column :drivers, :isactive, :boolean, default: true
  end
end
