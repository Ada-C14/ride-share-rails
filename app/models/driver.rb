class Driver < ApplicationRecord
  has_many :trips

  validates :name, presence: true
  validates :vin, presence: true

  def total_earnings
    every_costs = self.trips.where.not(cost: nil)
    sum = 0
    every_costs.each do |trip|
      if trip.cost <= 1.65 * 100
        sum += trip.cost
      else
        sum += (trip.cost - 1.65 * 100) * 0.8
      end
    end

    if sum
      return (sum / 100).round(2)
    else
      return nil
    end
  end

  def ave_rating
    rating_by_passengers = self.trips.where.not(rating: nil)
    sum = rating_by_passengers.sum { |trip| trip.rating}

    if sum
      return (sum / rating_by_passengers.count.to_f).round(1)
    else
      return nil
    end
  end
end
