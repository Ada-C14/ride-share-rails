class Driver < ApplicationRecord
  has_many :trips

  validates :name, presence: true
  validates :vin, presence: true, length: { in: 11..17 }

  def total_earned
    return self.trips.inject(0) {|sum, trip| sum + (trip.cost-165) * 0.8 }
  end

  def average_rating
    return (self.trips.inject(0) {|sum, trip| sum + trip.rating.to_f } ) / self.trips.count
  end

end
