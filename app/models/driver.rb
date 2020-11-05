class Driver < ApplicationRecord
  has_many :trips
  validates :vin, presence: true
  validates :name, presence: true

  def total_revenue
    total = 0
    fee_per_trip = 1.65
    earning_rate = 0.8

    self.trips.each do |trip|
      # unless trip.end_time.nil???????
      total += trip.cost - fee_per_trip
    end

    earning = total * earning_rate
    if earning.negative?
      return 0
    else
      return earning.round(2)
    end
  end

  def average_rating
    ratings = self.trips.map{ |trip| trip.rating.to_f }
    unless ratings.empty?
      return (ratings.sum/ratings.length).round(1)
    end
    return 0
  end

  def change_status
    if self.available == false
      self.available = true
    else
      self.available = false
    end
  end


end
