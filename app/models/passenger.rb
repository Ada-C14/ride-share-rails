class Passenger < ApplicationRecord
  has_many :trips
  validates :name, presence: true
  validates :phone_num, presence: true

  def total_charged
    if self.trips.empty?
      return " $0.00"
    end

    dollars = 0

    self.trips.each do |trip|

      dollars += trip.cost
    end
    dollars = sprintf('%.2f', (dollars.to_f / 100))

    return " $#{dollars}"
  end

end


