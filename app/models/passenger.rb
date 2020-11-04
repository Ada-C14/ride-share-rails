class Passenger < ApplicationRecord
  has_many :trips

  def passenger_cost
    cost = 0

    trips.each do |trip|
      if trip.cost != nil
        cost += trip.cost
      end
    end

    # alternative 'active record' syntax:
    # cost = trips.where.not(cost: nil).to_a.sum(&:cost)

    cost = cost.to_f/100
    return cost.round(2)
    end
  end

