class Passenger < ApplicationRecord

  has_many :trips, dependent: :nullify
  validates :name, presence: true
  validates :phone_num, presence: true

  def total_amount_charged
    return 0 if self.trips.empty?
    trips_with_cost = self.trips.where.not(cost: nil)
    total_amount_charged = trips_with_cost.map{ |trip| trip.cost}
    return total_amount_charged.sum
  end

  paginates_per 15

end
