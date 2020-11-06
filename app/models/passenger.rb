class Passenger < ApplicationRecord
  has_many :trips

  validates :name, presence: true
  validates :phone_num, presence: true

  def request_trip
    driver = find_driver

    if driver
      driver.toggle_available
    else
      return false
    end

    return self.trips.new(date: Date.current, cost: rand(100..9999), driver: driver)
  end

  private

  def find_driver
    return Driver.find_by(available: true)
  end
end


