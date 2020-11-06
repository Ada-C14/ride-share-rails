class Trip < ApplicationRecord
  belongs_to :passenger
  belongs_to :driver

  validates :driver_id, presence: true, numericality: { only_integer: true, greater_than: 0 }
  validates :passenger_id, presence: true, numericality: { only_integer: true, greater_than: 0 }
  validates :date, presence: true
  validates :rating, numericality: { only_integer: true, greater_than: 0, less_than: 6 }, allow_nil: true, allow_blank: true
  validates :cost, numericality: { only_integer: true, greater_than: 0 }


  def self.request_trip(passenger_id)
    @trip = Trip.new
    @trip.passenger_id = passenger_id

    @driver = Driver.find_by(available: true)
    @driver.available = false
    @driver.save
    @trip.driver_id = @driver.id

    @trip.date = Date.today
    @trip.cost = rand(1..9999)
    return @trip
  end
end
