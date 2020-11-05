class Passenger < ApplicationRecord
  has_many :trips
  validates :name, presence: true
  validates :phone_num, presence: true

  def total_charged
    trips = self.trips.where.not(cost: nil)
    return 0 if trips.empty?

    trips_costs = trips.map { |trip| trip.cost}
    total = (trips_costs.sum.to_f)/100

    return total
  end

  def request_ride

  end
end
