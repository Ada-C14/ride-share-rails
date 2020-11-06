class Passenger < ApplicationRecord
  has_many :trips, dependent: :destroy
  validates :name, presence: true
  validates :phone_num, presence: true

  def total_charged
    trips = self.trips.where.not(cost: nil)
    return 0 if trips.empty?

    trips_costs = trips.map { |trip| trip.cost}
    total = (trips_costs.sum.to_f)/100

    return total
  end

  def request_trip
    driver = Driver.select_available
    passenger = self
    cost = rand(1000..9999)
    date = Date.today

    params = {
            driver_id: driver.id,
            passenger_id: passenger.id,
            cost: cost,
            date: date
    }

    return params
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
  end

  def complete_trip(trip)
    driver = Driver.find_by(id: trip.driver_id)
    driver.toggle_available
  end

end
