# frozen_string_literal: true
class Driver < ApplicationRecord
  has_many :trips
  def average_rating(driver)
    ratings = driver.trips.map {|trip| trip.rating}
    total_ratings = 0
      ratings.each do |rating|
        total_ratings += rating
      end
    average = total_ratings.to_f / ratings.length
    return average.round(1)
  end
  def total_money(driver)
    costs = driver.trips.map {|trip| trip.cost}
    total = 0
    costs.each do |cost|
      total += cost
    end
    return total

  end

  def list_all_trips(driver)
    # trip_ids = driver.trips.map {|trip| trip.id}
    # trip_passengers = driver.trips.map {|trip| trip.passenger_id}
    # trip_dates = driver.trips.map {|trip| trip.date}
    # trip_rating = driver.trips.map {|trip| trip.rating}
    # trip_cost = driver.trips.map {|trip| trip.cost}
    trips = driver.trips.map {|trip| trip}
    trips_hash = Hash[trips.map {|key, value| [key, value]}]
    # trips_hash = trips_hash.delete(:created_at)
    return trips_hash
  end

  # def better_hash(driver)
  #   keys = [:created_at, :updated_at]
  #   trips_hash = list_all_trips(driver)
  #   new_hash = trips_hash.delete(:created_at)
  #   # new_hash = trips_hash.delete(:updated_at)
  #   return new_hash



  # end
end
