class Passenger < ApplicationRecord
  has_many :trips
  validates :name, presence: true
  validates :phone_num, presence: true

  def net_expenditures
    if self.trips.empty?
      return 0
    else
      self.trips.inject(0) do |total_cost, trip|
        if trip.cost.nil?
          total_cost
        else
          total_cost + trip.cost
        end
      end
    end
  end

  # def find_driver(id)
  #   Driver.validate_id(id)
  #   @drivers.find { |drivers| drivers.available == true }
  # end

  def request_trip
    # passenger = find_passenger(passenger_id)
    # find all available
    # available_drivers = Driver.find_all { |driver| driver.available }
    available_drivers = Driver.where(:available => true)

    raise ArgumentError, 'No drivers available' if available_drivers.empty?

    new_trip = Trip.create(passenger: self, driver: available_drivers.first, date: Date.today, rating: nil, cost: rand(100..1000))
    # new_trip.connect(passenger, idle_driver)
    # idle_driver.unavailable_driver
    available_drivers.first.available = false
    new_trip
  end
end
