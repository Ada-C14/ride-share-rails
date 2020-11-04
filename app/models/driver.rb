class Driver < ApplicationRecord
  has_many :trips

  def total_earnings
    costs = self.trips.filter.sum { |trip| ! trip.cost.nil? && trip.cost > 1.65 ? 0.8 * (trip.cost - 1.65) : 0 }
    return costs
  end

  def avg_rating
    valid_ratings = self.trips.filter { |trip| ! trip.rating.nil? }
    sum_ratings = valid_ratings.sum(0.0) { |trip| trip.rating }
    return sum_ratings / valid_ratings.length
  end
end
