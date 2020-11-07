class Passenger < ApplicationRecord
  has_many :trips

  validates :name, presence: true
  validates :phone_num, presence: true, uniqueness: true

  def total_cost
    costs = self.trips.map { |trip| trip.cost }
    return costs.sum
  end
end
