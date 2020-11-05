class Driver < ApplicationRecord
  has_many :trips
  validates :name, presence: true
  validates :vin, presence: true, format: { with: /\b[a-zA-Z0-9]{17}/ }

  def total_earned
    return self.trips.map { |trip| 0.8 * (trip.cost/100.0 - 1.65) }.sum
  end

  def average_rating
    trips_for_driver = self.trips
    ratings = 0
    count = 0
    trips_for_driver.each do |trip|
      if !trip.rating.nil?
        ratings += trip.rating
        count += 1
      end
    end
    if count == 0
      return nil
    else
      return ratings / count
    end
  end

end
