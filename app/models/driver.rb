class Driver < ApplicationRecord
  has_many :trips

  validates :name, presence: true
  validates :vin, presence: true #, length: { is: 17 }

  def toggle_available
    self.update(available: !self.available)
  end

  def total_earnings
    gross_earnings = self.trips.map{|trip| trip.cost}.sum

    return gross_earnings > 165 ? ((gross_earnings - 1.65) * 0.8).round : 0
  end
end
