class Driver < ApplicationRecord
  has_many :trips

  validates :name, presence: true
  validates :vin, presence: true

  attribute :available, default: true

  def mark_unavailable
    self.available = false
    self.save
  end
#  drivers total earnings
  #  driver gets 80% of the trip cost after a fee of $1.65 is subtracted
  def total_revenue
    return 0 if self.trips.length == 0

    commission = 0.8
    fee = 165
    total = 0
    self.trips.each do |trip|
      if trip.cost > fee
        total += (trip.cost - fee) * commission
      else
        total += (trip.cost * commission)
      end
    end
    return total.ceil
  end

  def average_rating
    total_rating = 0.0
    rated_trips = 0

    self.trips.each do |trip|
      if trip.rating != nil
        total_rating += trip.rating
        rated_trips += 1
      end
    end
    return self.trips.length > 0 ? (total_rating / rated_trips).round(1) : total_rating
  end
end

