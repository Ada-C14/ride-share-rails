class AddTripDateDatetimeColumn < ActiveRecord::Migration[6.0]
  def change
    add_column :trips, :date, :datetime
  end
end
