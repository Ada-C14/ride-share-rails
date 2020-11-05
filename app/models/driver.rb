class Driver < ApplicationRecord
  has_many :trips
  validates :name, presence: true
  validates :vin, presence: true
  # validates :available, inclusion: { in: [true, false] }

  # business logic
  def avg_rating
    return 0 if self.trips.empty?

    return (self.trips.sum { |trip| trip.rating.to_f } / self.trips.length).round(2)
  end

  def total_earnings
    return 0 if self.trips.empty?

    return (self.trips.sum { |trip| (trip.cost.to_f / 100) - 1.65 } * 0.8).round(2)
  end

end
