class Driver < ApplicationRecord
  has_many :trips

  validates :name, presence: true
  validates :vin, presence: true, length: { in: 11..17 }

  def total_earned
    return self.trips.inject(0) {|sum, trip| sum + (trip.cost-165) * 0.8 }
  end

  def average_rating
    return 0 if self.trips.empty?

    count = 0
    total= 0
    self.trips.each do |trip|
      if trip.rating
        total += trip.rating.to_f
        count += 1
      end
    end
    return 0 if count == 0
    return total/count
  end

end
