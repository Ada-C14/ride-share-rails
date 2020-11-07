class Driver < ApplicationRecord
  has_many :trips

  validates :name, presence: true
  validates :vin, presence: true, length: { is: 17}

  def mark_unavailable
    self.available = false
    self.save
  end

  # calculate total earnings
  def total_earnings
    if self.trips.empty?
      return 0
    end

    revenue = self.trips.map { |trip| (trip[:cost] / 100.0 - 1.65) * 0.8 }
    total = revenue.sum

    return total
  end

  # calculate average rating
  def average_rating
    ratings = self.trips.map { |trip| trip[:rating] }
    mean = (ratings.sum.to_f) / (ratings.length)

    return mean
  end
end
