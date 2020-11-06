class TripsController < ApplicationController

  def index
    @trips = Trip.all
  end

  def show
    trip_id = params[:id].to_i
    @trips = Trip.find_by(id: trip_id)
    if @trips.nil?
      head :not_found
      return
    end
  end

  def create
    driver = Driver.find_by(:available = true)
    passenger = Passenger.find_by(id: params[:pasenger_id])

    @trip = Trip.new(
        driver_id = driver.id,
        passenger_id = passenger.id
    )
    @trip.save
    driver.unavailable
  end

end
