class Driver < ApplicationRecord
  has_many :trips

  validates :name, :vin, presence: true
  validates :vin, uniqueness: true

  def mean_rating
    sum = 0
    trips.each do |trip|
      sum += trip.cost
    end
    mean = sum / trips.count
  return mean
  end
end

