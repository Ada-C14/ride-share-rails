class AddIsactiveToPassengers < ActiveRecord::Migration[6.0]
  def change
    add_column :passengers, :isactive, :boolean, default: true
  end
end
