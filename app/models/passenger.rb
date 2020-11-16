class Passenger < ApplicationRecord
  has_many :trips

  validates :name, presence: true
  validates :phone_num, presence: true

  # calculate total charges
  def total_charges
    if self.trips.empty?
      return 0
    end

    revenue = self.trips.map { |trip| (trip[:cost] / 100.0) }
    total = revenue.sum

    return total
  end
end
