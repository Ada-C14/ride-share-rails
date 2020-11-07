class Trip < ApplicationRecord
  belongs_to :driver
  belongs_to :passenger

  validates :driver_id, presence: true
  validates :passenger_id, presence: true
  validates :rating, numericality: { only_integer: true, greater_than: 0, less_than: 6, allow_nil: true }
  validates :cost, presence: true, numericality: { greater_than: 0 }
   validates :date, presence: true

  def cost_in_dollars
    return (cost / 100.0).round(2)
  end

  def cost_in_dollars=(value)
    self.cost = value.to_f * 100
  end

   # Making this as a class method to request trip
  def self.request_trip(passenger)
    available_drivers = Driver.where(:available => true)

    raise ArgumentError, 'No drivers available' if available_drivers.empty?

    Trip.new(passenger: passenger, driver: available_drivers.first, date: Date.today, rating: nil, cost: rand(100..1000))
  end
end
