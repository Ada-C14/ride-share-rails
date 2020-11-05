class Passenger < ApplicationRecord
  has_many :trips

  validates :name, presence: true
  validates :phone_number, presence: true, uniqueness: true

  def total_charged
    return self.trips.sum { |trip| trip.cost }.round(2)
  end
end
