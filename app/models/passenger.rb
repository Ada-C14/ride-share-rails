class Passenger < ApplicationRecord
  validates :name, presence: true
  validates :phone_num, presence: true

  has_many :trips

  def total_cost
    # get the of trips for the passenger
    # add the cost together
    # sum = 0

    if self.trips.empty?
      return 0
    else
      # self.trips.each do |trip|
      #   sum += trip.cost
      # end
      return self.trips.map{|trip| trip.cost}.sum
    end
    # return sum
  end

end
