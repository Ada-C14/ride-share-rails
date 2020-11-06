class Driver < ApplicationRecord
  has_many :trips

  validates :name, presence: true
  validates :vin, presence: true , length: { is: 17 }

  def toggle_available
    self.update(available: !self.available)
  end

  def total_earnings
    gross_earnings = self.trips.map{|trip| trip.cost}.compact.sum

    return gross_earnings > 165 ? ((gross_earnings - 165) * 0.8).round : 0
  end

  def avg_rating
    return self.trips.empty? ? 0 : (self.trips.map{|trip| trip.rating}.compact.sum/self.trips.length).round
  end


end
