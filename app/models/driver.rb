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

  def average_rating
    average = 0
    sum = 0
    count = 0
    trips.each do |trip|
      sum += trip.rating
      count += 1
    end
    average = (sum / count.to_f).round(2)
    return average
  end

end
