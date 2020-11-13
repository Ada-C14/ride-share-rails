class Trip < ApplicationRecord
  belongs_to :driver
  belongs_to :passenger

  validates :driver, presence: true
  validates :passenger, presence: true
  validates :date, presence: true
  validates :cost, presence: true, numericality: { only_integer: true }

  def self.average_rating
    trips = Trip.all
    trip_count = trips.size

    average_rating = 0
    ratings = []

    if trip_count == 0
      average_rating = "Not available"
    else
      trips.each do |trip|
        unless trip.rating.nil?
          ratings << trip.rating
        end
      end
      unless ratings.length == 0
        average_rating = ((ratings.sum.to_f) / ratings.length).round(1)
      end
    end

    return average_rating
  end

  def self.total_revenue
    trips = Trip.all
    trip_count = trips.size

    total_revenue = 0
    if trip_count == 0
      total_revenue = "N/A"
    else
      trips.each {|trip| total_revenue += trip.cost }
    end

    return total_revenue
  end

end
