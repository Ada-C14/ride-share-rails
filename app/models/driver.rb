class Driver < ApplicationRecord
  has_many :trips

  validates :name, presence: true
  validates :vin, presence: true, length: { is: 17 }
  # validates :available, presence: true, inclusion: { in: [true, false] }

  def average_rating
    rated_trips = self.trips.where.not(rating: nil)
    return 0 if rated_trips.empty?

    all_ratings = rated_trips.map { |trip| trip.rating }
    average = all_ratings.sum / all_ratings.length.to_f
    return average.round(1)
  end

  def total_earnings
    paid_trips = self.trips
    return 0 if paid_trips.empty?

    trip_income = paid_trips.map do |trip|
      if trip.cost <= 165
        trip.cost * 0.8
      else
        (trip.cost - 165) * 0.8
      end
    end

    total = trip_income.sum / 100
    return total.round(2)
  end

  def toggle_available
    if self.available
      self.available = false
    else
      self.available = true
    end
  end
end
