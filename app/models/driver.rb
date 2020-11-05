class Driver < ApplicationRecord
  has_many :trips
  validates :name, :vin, presence: true

  def total_earnings
    per_trip_fee = 1.65
    total_earnings = self.trips.sum(:cost)
    total_earnings_net_fees = total_earnings - per_trip_fee * self.trips.count
    net_earnings = total_earnings_net_fees * 0.8

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
