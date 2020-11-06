class Driver < ApplicationRecord
  has_many :trips


  def earned
    sum = 0
    trips.each do |trip|
      if trip.cost < 0
        return 0
      else
        sum += (trip.cost - 165) * 0.8
      end
    end
    return sum.round(2)
  end

end
