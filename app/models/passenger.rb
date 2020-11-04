class Passenger < ApplicationRecord
  has_many :trips

  def total_cost
    costs = self.trips.map { |trip| trip.cost }
    return costs.sum
  end
end
