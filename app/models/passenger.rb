class Passenger < ApplicationRecord
  has_many :trips

  def total_spent
    total_spent = 0
    trips.each do |trip|
      total_spent += trip.cost
    end
    return total_spent
  end
end
