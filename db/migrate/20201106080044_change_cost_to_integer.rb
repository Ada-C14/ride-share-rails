class ChangeCostToInteger < ActiveRecord::Migration[6.0]
  def change
    change_column :trips, :cost, :integer
  end
end
