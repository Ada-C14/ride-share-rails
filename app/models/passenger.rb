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

<<<<<<< HEAD
    return params
=======
    if params.values.include?(nil)
      driver.toggle_available
      return nil
    else
      return params
    end
>>>>>>> final_tests_branch
  end

  def complete_trip(trip)
    driver = Driver.find_by(id: trip.driver_id)
    driver.toggle_available
  end

end
