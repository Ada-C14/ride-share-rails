class Driver < ApplicationRecord
    has_many :trips

    def average_rating
        return self.trips.average(:rating)
    end
end
