class Passenger < ApplicationRecord
  has_many :trips, dependent: :destroy
  validates :name, presence: true
  validates :phone_num, presence: true

  def lifetime_cost
    lifetime_cost = self.trips.sum(:cost)
    return lifetime_cost
  end
end
