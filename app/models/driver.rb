class Driver < ApplicationRecord
  has_many :trips, dependent: :destroy
  validates :name, :vin, presence: true

  PER_TRIP_FEE = 1.65
  DRIVER_PCT_TAKE_HOME = 0.8

  def total_earnings
    total_earnings = self.trips.sum(:cost)
    total_earnings_net_fees = total_earnings - PER_TRIP_FEE * self.trips.count
    net_earnings = total_earnings_net_fees * DRIVER_PCT_TAKE_HOME

    return net_earnings
  end

  def average_rating
    avg_rating = self.trips.where.not(rating: nil).sum(:rating)
    total_trips = self.trips.count(:rating)

    return nil if total_trips.zero? || avg_rating.zero?

    avg_rating /= total_trips

    return avg_rating
  end
end
