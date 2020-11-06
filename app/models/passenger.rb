require 'money'

class Passenger < ApplicationRecord
  has_many :trips
  validates :name, presence: true
  validates :phone_num, presence: true

  def total_cost
    total_cost = 0
    self.trips.each do |trip|
      total_cost += trip.cost
    end
    return Money.new(total_cost, "USD").format
  end

  def self.request_trip
    #  check if already on trip
    trip = self.trips.where(rating: nil)
    if trip
      return 'in progress'
    else
      return 'request accepted'
    end
  end

  def self.complete_trip
    trip = self.trips.where(rating: nil)
    trip.rating = rand(1...5)
    self.save
  end
end
