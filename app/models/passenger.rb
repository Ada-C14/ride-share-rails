class Passenger < ApplicationRecord
  has_many :trips

  validates :name, presence: true
  validates :phone_num, presence: true, length: {is: 10}, numericality: {only_integer: true}

    # calculate total charges
    def total_charges
      if self.trips.empty?
        return 0
      end
  
      revenue = self.trips.map { |trip| (trip[:cost] / 100.0 ) }
      total = revenue.sum
  
      return total
    end

end