class Driver < ApplicationRecord
  has_many :trips
  validates :name, presence: true
  validates :vin, presence: true

  def total_earned
    return self.trips.map { |trip| 0.8 * (trip.cost/100.0 - 1.65) }.sum
  end


end
