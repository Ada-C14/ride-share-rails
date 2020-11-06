class TripsController < ApplicationController
    
  def index
    if params[:driver_id]
      # This is the nested route, /driver/:driver_id/trips
      driver = Driver.find_by(id: params[:driver_id])
      @trips = driver.trips
    elsif params[:passenger_id]
      passenger = Passenger.find_by(id: params[:passenger_id]) 
      @trips = passenger.trips
    else
      # This is the 'regular' route, /trips
      @trips = Trip.all
    end
  end

  def show # details of an instance of an object

    if params[:driver_id]
      driver = Driver.find_by(id: params[:driver_id])
      raise
      trip = driver.trips.find_by(id: 124)
    end


    passenger_id = params[:id]
    @passenger = Passenger.find_by(id: passenger_id)

    if @passenger.nil?
      redirect_to passengers_path
      return
    end
end
    
end
