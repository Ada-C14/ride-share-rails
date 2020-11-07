class Driver < ApplicationRecord
  has_many :trips

  validates :name, :vin, presence: true
  validates :vin, uniqueness: true

  def mean_rating
    sum = 0
    trips.each do |trip|
      if trip.rating != nil
        sum += trip.rating
      end
    end
    mean = sum / trips.count
  return mean
  end

  #The driver gets 80% of the trip cost after a fee of $1.65 is subtracted
  def total_earnings
    sum = 0
    trips.each do |trip|
      if trip.cost < 0
        return 0
      else
        sum += (trip.cost - 165) * 0.8
      end
    end
    return sum/100
  end
end
