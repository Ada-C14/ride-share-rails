class Driver < ApplicationRecord
    has_many :trips

    validates :name, presence: true
    validates :vin, presence: true

    def average_rating
        avg_rating = self.trips.average(:rating)
        if avg_rating == nil
            return nil
        else
            return avg_rating.round(2)
        end

    end

    def total_earnings
        total = self.trips.sum(:cost)
        return (total - 1.65) * 0.8
    end 
end
