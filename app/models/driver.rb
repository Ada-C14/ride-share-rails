class Driver < ApplicationRecord
  validates :vin, presence: true
  validates :name, presence: true
  # validates :available, presence: true

  has_many :trips

  def average_rating
    ratings = self.trips.map { |trip| trip.rating }
    average = ratings.sum / ratings.length.to_f
    return average / 10 == 0 ? average : average.round(1)
  end

  def total_earnings
    total = self.trips.map {|trip| trip.cost * 0.8 - 1.65}.sum
    return total.round(2)
  end

  def single_trip_earnings(trip)
    return (trip.cost * 0.8 - 1.65).round(2)
  end
end
