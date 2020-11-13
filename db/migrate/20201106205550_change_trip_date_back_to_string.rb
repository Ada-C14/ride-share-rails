class ChangeTripDateBackToString < ActiveRecord::Migration[6.0]
  def change
    remove_column :trips, :date
    add_column :trips, :date, :string
  end
end
