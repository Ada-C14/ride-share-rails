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

  def request_trip
    available_drivers = Driver.where(:available => true)

    raise ArgumentError, 'No drivers available' if available_drivers.empty?

    Trip.new(passenger: self, driver: available_drivers.first, date: Date.today, rating: nil, cost: rand(100..1000))
  end
end
