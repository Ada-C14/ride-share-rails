class Passenger < ApplicationRecord
  has_many :trips
  validates :name, presence: true
  validates :phone_num, presence: true

  def total_spending
    return 0 if self.trips.empty?

    return (self.trips.sum { |trip| trip.cost.to_f }) / 100
  end
end
