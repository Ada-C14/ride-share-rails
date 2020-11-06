class Driver < ApplicationRecord
  has_many :trips

  validates :name, presence: true
  validates :vin, presence: true

  def self.find_available_driver
    return Driver.where(available: true).first
  end
  def mark_unavailable
    self.available = false
    self.save
  end
#  drivers total earnings
  #  driver gets 80% of the trip cost after a fee of $1.65 is subtracted
  def total_revenue
    commission = 0.8
    fee = 1.65
    total = 0
    self.trips.each do |trip|
      if trip.cost > fee
        total += (trip.cost - fee) * commission
      else
        total += (trip * commission)
      end
      return total
    end
  end

  def average_rating
    total_rating = 0
    rated_trips = 0

    self.trips.each do |trip|
      if trip.rating != nil
        total_rating += trip.rating
        rated_trips += 1
      end
    end
    self.trips.length > 0 ? total_rating / rated_trips.to_f : total_rating
  end

  def marke_unavailable
    self.available = false
    self.save
  end

end

