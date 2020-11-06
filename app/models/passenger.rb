class Passenger < ApplicationRecord
  has_many :trips

  validates :name, presence: true
  validates :phone_number, presence: true, uniqueness: true

  def total_charged
    return self.trips.sum { |trip| trip.cost }.round(2)
  end

  def request_trip
    driver = Driver.next_available
    driver.change_status
    return Trip.new(rating: nil, cost: rand(5.00..30.00).round(2), passenger: self, driver: driver, date: Time.now)
  end

end
