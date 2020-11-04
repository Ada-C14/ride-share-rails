class Driver < ApplicationRecord
    has_many :trips

    def average_rating
        return self.trips.average(:rating)
    end

    def total_earnings
        total = self.trips.sum(:cost)
        return (total - 1.65) * 0.8
    end 
end
