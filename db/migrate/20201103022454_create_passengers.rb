class CreatePassengers < ActiveRecord::Migration[6.0]
  def change
    create_table :passengers do |t|
      t.integer :ride_id
      t.string :name
      t.string :phone_num

      t.timestamps
    end
  end
end
