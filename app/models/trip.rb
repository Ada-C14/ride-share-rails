class Trip < ApplicationRecord
  validates :rating, numericality: { only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 5, allow_nil: true}
  validates :cost, presence: true, numericality: { greater_than: 0 }

  belongs_to :driver
  belongs_to :passenger

  def complete_trip
    if self.rating
      driver = Driver.find_by(id: self.driver_id)
      driver.set_available
    end
  end

  def self.request_trip(driver, passenger)
    return Trip.new(date: Time.now.strftime("%Y-%m-%d"),
             driver_id: driver.id ,
             # how to set the same passenger id?
             passenger_id: passenger.id,
             rating: nil,
             # get a random number
             cost: rand(5.0..90.5).round(2)
    )
  end
end
