class HomepagesController < ApplicationController

  def index
    drivers = Driver.all 

    if drivers.empty?
      @driver_count = 0
      @available_drivers = "N/A"
      @unavailable_drivers = "N/A"
    else
      @driver_count = drivers.size
      @available_drivers = drivers.where(available: true).size
      @unavailable_drivers = drivers.where(available: false).size
    end

    passengers = Passenger.all
    if passengers.empty?
      @passenger_count = 0
    else
      @passenger_count = passengers.size
    end

    trips = Trip.all
    if trips.empty?
      @trip_count = 0
    else
      @trip_count = trips.size
    end

    @average_rating = Trip.average_rating

    @total_revenue = Trip.total_revenue
  end
end
