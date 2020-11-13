class Driver < ApplicationRecord
  has_many :trips

  validates :name, presence: true
  validates :vin, presence: true, uniqueness: true, length: { is: 17 }

  def total_earnings
    costs = self.trips.filter.sum { |trip| trip.cost && trip.cost > 165 ? 0.8 * (trip.cost - 165) : 0 }
    return costs
  end

  def avg_rating
    return 0 if trips.empty?

    valid_ratings = self.trips.filter { |trip| trip.rating }
    sum_ratings = valid_ratings.sum(0.0) { |trip| trip.rating }
    return (sum_ratings / valid_ratings.length).round(1)
  end
end
