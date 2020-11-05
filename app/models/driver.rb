class Driver < ApplicationRecord
  has_many :trips

  validates :name, presence: true
  validates :vin, presence: true, length: { is: 17 }
  # validates :available, presence: true, inclusion: { in: [true, false] }

  # def all_trips
  #   return self.trips
  # end

  def average_rating
    rated_trips = self.trips.where.not(rating: nil)
    return 0 if rated_trips.empty?
    
    all_ratings = rated_trips.map { |trip| trip.rating }
    average = all_ratings.sum / all_ratings.length.to_f
    return average.round(1)
  end
end
