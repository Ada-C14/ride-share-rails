class HomepagesController < ApplicationController

  def index
    drivers = Driver.all #would it better to write these in a driver model method etc.?  Probably too much logic should move to Driver model

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
    #@trip_count = 0

    #should move this logic to trips model?
    ratings = []
    if @trip_count == 0
      @average_rating = "Not available"
    else
      trips.each do |trip|
        unless trip.rating.nil?
          ratings << trip.rating
        end
      end
      unless ratings.length == 0
        @average_rating = (ratings.sum) / ratings.length
      end
    end

    @total_revenue = 0
    if @trip_count == 0
      @total_revenue = "N/A"
    else
      trips.each {|trip| @total_revenue += trip.cost }
    end
  end
end
