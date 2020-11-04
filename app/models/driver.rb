class Driver < ApplicationRecord
  has_many :trips

  # business logic
  def avg_rating
    return 0 if self.trips.empty?

    return (self.trips.sum { |trip| trip.rating.to_f } / self.trips.length).round(2)
  end

  def total_earnings

  end

end
