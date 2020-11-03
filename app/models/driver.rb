# frozen_string_literal: true
class Driver < ApplicationRecord
  has_many :trips
  def average_rating(driver)
    ratings = driver.trips.map {|trip| trip.rating}
    trips.each do |trip|
      ratings << trip[:rating]
    end
    total_ratings = 0
      ratings.each do |rating|
        total_ratings += rating
      end
    average = total_ratings.to_f / ratings.length
    return average.round(1)
  end
end
