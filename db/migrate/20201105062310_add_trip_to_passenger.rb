class AddTripToPassenger < ActiveRecord::Migration[6.0]
  def change
    add_reference :passengers, :trip, index: true
  end
end
