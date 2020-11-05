class Passenger < ApplicationRecord
  has_many :trips

  validates :name, presence: true
  validates :phone_num, presence: true

  def total_spent
    total = self.trips.sum(:cost)/100
    return total > 0 ? total : 0
  end
end
