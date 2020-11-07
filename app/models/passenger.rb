class Passenger < ApplicationRecord
  has_many :trips

  validates :name, :phone_num, presence: true
  validates :phone_num, uniqueness: true


  def total_expenditure
    total_cost = 0

    trips.each do |trip|
      total_cost += trip.cost
    end
    return total_cost
  end


end
