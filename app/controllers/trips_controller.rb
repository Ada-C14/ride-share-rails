class TripsController < ApplicationController

  TRIPS = [
    {
      id: 1,
      driver_id: 1,
      passenger_id: 54,
      date: "2016-04-05",
      rating: 3, 
      cost: 1293
    },

    {
      id: 2,
      driver_id: 67,
      passenger_id: 146,
      date: "2016-01-13",
      rating: 5, 
      cost: 2157
    },
  ]

  def index
    @trips = TRIPS
  end

  def show
    trips_id = params[:id].to_i
    @trips = TRIPS[trips_id]
    if @trips.nil?
      head :not_found
      return
    end
  end

end
