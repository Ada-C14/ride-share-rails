class Passenger < ApplicationRecord
  has_many :trips
  validates :name, presence: true
  validates :phone_num, presence: true

  def total_charged
    dollars = 0

    self.trips.each do |trip|

      dollars += trip.cost
    end
    dollars = (dollars.to_f / 100)
    return " $#{dollars.to_s}"

  end

end


