class CreateRideshares < ActiveRecord::Migration[6.0]
  def change
    create_table :rideshares do |t|

      t.timestamps
    end
  end
end
