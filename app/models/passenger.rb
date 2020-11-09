class Passenger < ApplicationRecord
  has_many :trips
  validates :name, presence: true
  # validates :name, length: { minimum: 2 }
  validates :phone_num, presence: true
  # validates :phone_num, numericality: { only_integer: true}
  # validates :phone_num, length: { in: 6..10 }

  def passenger_cost
    cost = 0
    trips.each do |trip|
      if trip.cost != nil
        cost += trip.cost
      end
    end
    # alternative 'active record' syntax: replaces each loop above with enumerable
    # cost = trips.where.not(cost: nil).to_a.sum(&:cost)
    cost = cost.to_f/100
    return cost.round(2)
  end

end

