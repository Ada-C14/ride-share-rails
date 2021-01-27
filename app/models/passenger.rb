class Passenger < ApplicationRecord
  has_many :trips

  validates :name, presence: true
  validates :phone_num, presence: true, uniqueness: true

  def total_spent
    return self.trips.inject(0) {|sum, trip| sum + trip.cost}
  end
end
