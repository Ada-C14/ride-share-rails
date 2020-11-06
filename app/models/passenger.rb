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

  # def request_ride
  #   found_driver = Driver.find_by(available: true)
  #   cost = rand(1000..9999)
  #   if found_driver
  #     @trip = Trip.new(driver_id: found_driver, passenger_id: self.id, date: Date.today, cost: cost)
  #     return @trip
  #   else
  #     #no drivers are available, what to do?
  #   end
  #
  #   #return @trip
  # end

  def complete_trip(trip)
    driver = Driver.find_by(id: trip.driver_id)
    driver.toggle_available
  end

end
