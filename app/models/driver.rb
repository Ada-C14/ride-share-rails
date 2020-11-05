class Driver < ApplicationRecord
  has_many :trips
  validates :name, :vin, presence: true

  def total_earnings
    total_earnings = self.trips.sum(:cost)

    return total_earnings
  end

  def average_rating
    avg_rating = self.trips.where.not(rating: nil).sum(:rating)
    total_trips = self.trips.count(:rating)

    return nil if total_trips.zero? || avg_rating.zero?

    avg_rating /= total_trips

    return avg_rating
  end
end
