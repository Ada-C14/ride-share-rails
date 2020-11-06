class HomepagesController < ApplicationController

  def index
    drivers = Driver.all #would it better to write these in a driver model method etc.?
    @driver_count = drivers.size
    @available_drivers = drivers.where(available: true).size
    @unavailable_drivers = drivers.where(available: false).size


    passengers = Passenger.all
    @passenger_count = passengers.size

    trips = Trip.all
    @trip_count = trips.size

    ratings = []
    trips.each do |trip|
      unless trip.rating.nil?
        ratings << trip.rating
      end
    end
    @average_rating = (ratings.sum) / ratings.length
  end
    
    #@ave_trip_rating = trips.size
    # # Sum some numbers
    # (5..10).reduce(:+)                             #=> 45
    # # Same using a block and inject
    # (5..10).inject { |sum, n| sum + n }

end
