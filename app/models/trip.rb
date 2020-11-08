class Trip < ApplicationRecord
  belongs_to :driver
  belongs_to :passenger

  validates :driver_id, :passenger_id, :date, :cost, presence: true
  validates :cost, numericality: true

  def total_earnings
    return 0 if self.trips.empty?
    sum = 0
    trips.each do |trip|
      if trip.cost < 0
        return 0
      else
        sum += (trip.cost - 165) * 0.8
      end
    end
    return sum
  end
end
