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
end
