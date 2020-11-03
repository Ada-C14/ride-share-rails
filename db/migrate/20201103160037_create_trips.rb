class CreateTrips < ActiveRecord::Migration[6.0]
  def change
    create_table :trips do |t|
      t.integer :rating
      t.float :cost
      t.string :date

      t.timestamps
    end
  end
end
