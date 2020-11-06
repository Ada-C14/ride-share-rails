class Passenger < ApplicationRecord
    has_many :trips
    validates :phone_num, presence: true
    validates :name, presence: true

    def net_expenditures
        total = 0
        self.trips.each do |trip|
          total += trip.cost 
        end
        return total
    end

end
