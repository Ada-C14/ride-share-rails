class Driver < ApplicationRecord
  validates :name, presence: true
  validates :vin, length: {is: 17}
  # validates :available, presence: true

  has_many :trips, dependent: :destroy

  def average_rating
    all_ratings = self.trips.map { |trip| trip.rating}
    return nil if all_ratings.empty?

    number_ratings = all_ratings.filter { |rating| rating unless rating.nil?}
    average = number_ratings.sum / number_ratings.length.to_f
    return average / 10 == 0 ? average : average.round(1)
  end

  def total_earnings
    total = self.trips.map {|trip| trip.cost * 0.8 - 1.65}.sum
    return total.round(2)
  end

  def single_trip_earnings(trip)
    return (trip.cost * 0.8 - 1.65).round(2)
  end

  def self.get_available_driver
    return Driver.all.find {|driver| driver.available == true}
  end

  def set_available
    self.update(available: true)
  end

  def set_unavailable
    self.update(available: false)
  end
end
