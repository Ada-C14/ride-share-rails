class Passenger < ApplicationRecord
  has_many :trips
  validates :name, presence: true
  validates :phone_num, presence: true

  def total_spent
    if trips.empty?
      return 0
    else

    total_spent = 0
    trips.each do |trip|
      total_spent += trip.cost
    end
    end
    return total_spent
  end
end
