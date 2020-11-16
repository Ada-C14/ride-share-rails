class Passenger < ApplicationRecord
  has_many :trips
  validates :name, presence: true
  validates :phone_num, presence: true

  def total_cost
    total_sum = trips.sum(&:cost) / 100
    return total_sum
  end

end
