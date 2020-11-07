class Driver < ApplicationRecord
  has_many :trips

  validates :name, presence: true
  validates :vin, presence: true

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

    if ratings.length == 0
      mean = 0
    else
      mean = (ratings.sum.to_f) / (ratings.length)
    end

    return mean
  end
end
