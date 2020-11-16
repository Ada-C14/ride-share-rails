class Driver < ApplicationRecord
  has_many :trips

  validates :name, presence: true
  validates :vin, presence: true, length: { is: 17 }

  def total_earnings
    every_costs = self.trips.where.not(cost: nil)
    return nil if every_costs.empty?

    sum = 0
    every_costs.each do |trip|
      if trip.cost <= 1.65 * 100
        sum += trip.cost * 0.8
      else
        sum += (trip.cost - 1.65 * 100) * 0.8
      end
    end
    return (sum / 100).round(2)
  end

  def ave_rating
    rating_by_passengers = self.trips.where.not(rating: nil)
    return nil if rating_by_passengers.empty?

    sum = rating_by_passengers.sum { |trip| trip.rating}
    return (sum / rating_by_passengers.count.to_f).round(1)
  end
end
