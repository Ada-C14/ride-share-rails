class CreateTrips < ActiveRecord::Migration[6.0]
  def change
    create_table :trips do |t|
      t.references :driver, index: true
      t.references :passenger, index: true
      t.string :date
      t.integer :rating
      t.integer :cost

      t.timestamps
    end
  end
end
