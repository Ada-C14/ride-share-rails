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
    # find drivers with no in-progress trips
    # no_ip_drivers = []
    # available_drivers.each do |driver|
    #   nil_trip = false
    #   # check for trips with nil
    #   driver.trips.each do |trip|
    #     nil_trip = true if trip.end_time.nil?
    #   end
    #   # only shovel is !nil_trip
    #   no_ip_drivers << driver unless nil_trip
    # end
    # raise ArgumentError, 'No drivers available' if no_ip_drivers.empty?
    # find drivers with no trips
    # idle_driver = no_ip_drivers.find { |driver| driver.trips.empty? }
    # if result nil, all drivers have at least one trip, must compare for most "stale"
    # if idle_driver.nil?
    #   idle_driver = no_ip_drivers[0]
    #   driver_last_trip = idle_driver.trips.max_by(&:end_time)
    #   no_ip_drivers.each do |driver|
    #     last_trip = driver.trips.max_by(&:end_time)
    #     idle_driver = driver if last_trip.end_time < driver_last_trip.end_time
    #   end
    # end
    new_trip = Trip.create(passenger: self, driver: available_drivers.first, date: Date.today, rating: nil, cost: rand(100..1000))
    # new_trip.connect(passenger, idle_driver)
    # idle_driver.unavailable_driver
    available_drivers.first.available = false
    new_trip
  end
end
