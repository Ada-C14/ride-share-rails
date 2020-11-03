class CreateTrips < ActiveRecord::Migration[6.0]
  def change
    create_table :trips do |t|
      t.string :driver_id
      t.string :integer
      t.string :passenger_id
      t.string :integer
      t.string :date
      t.integer :rating
      t.integer :cost

      t.timestamps
    end
  end
end
