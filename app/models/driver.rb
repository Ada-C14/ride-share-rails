class Driver < ApplicationRecord
  has_many :trips

  validates :name, presence: true
  validates :vin, presence: true

  def average_rating
    return 0 if self.trips.empty?

    ratings = self.trips.map { |trip| trip[:rating] }
    numbers_only = ratings.reject { |item| item.nil? }
    average = numbers_only.sum / numbers_only.count.to_f
    return average.round(1)
  end

  def total_earnings
    return 0 if self.trips.empty?

    trip_costs = self.trips.map { |trip| trip[:cost] }
    sum_net_fee = 0
    trip_costs.each do |item|
      if item >= 1.65
        sum_net_fee += item - 1.65
      end
    end
    net_comission = sum_net_fee * 0.8
    return net_comission.round(2)
  end
end
