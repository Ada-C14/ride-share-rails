class Trip < ApplicationRecord
  belongs_to :driver
  belongs_to :passenger
  validates :date, presence: true
  validates :cost, presence: true

  def assign_driver
    driver = Driver.all.select {|driver| driver.available == true }.sample
    driver.available = false
    driver.save
    return driver
  end

  def self.trip_cost
    return rand(500..10000)
  end

end
