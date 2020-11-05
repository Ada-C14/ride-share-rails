class Driver < ApplicationRecord
  has_many :trips

  validates :name, presence: true

  validates :vin, presence: true, uniqueness: true

  def total_earnings

    sum_revenue = self.trips.sum { |trip| trip.cost > 1.65 ? 0.8 * (trip.cost - 1.65) : trip.cost }

    return sum_revenue.round(2)

  end

  def average_rating
    total_trips = trips.length
    return self.trips.sum { |trip| trip.rating.to_f }/total_trips
  end

  def change_status
    if self.availability_status
      self.availability_status = false
    else
      self.availability_status = true
    end
    self.save
    return
  end

end
