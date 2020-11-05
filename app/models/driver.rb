class Driver < ApplicationRecord
  has_many :trips
  validates :vin, presence: true
  validates :name, presence: true

  def total_revenue
    total = 0
    fee_per_trip = 1.65
    earning_rate = 0.8

    self.trips.each do |trip|
      total += trip.cost - fee_per_trip unless trip.end_time.nil?
    end

    earning = total * earning_rate
    if earning.negative?
      return 0
    else
      return earning.round(2)
    end
  end
end
