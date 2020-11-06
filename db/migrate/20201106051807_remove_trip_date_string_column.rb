class RemoveTripDateStringColumn < ActiveRecord::Migration[6.0]
  def change
    remove_column :trips, :date
  end
end
