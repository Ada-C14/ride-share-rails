class TripsController < ApplicationController
    
  # def index
  #   if params[:driver_id]
  #     # This is the nested route, /driver/:driver_id/trips
  #     driver = Driver.find_by(id: params[:driver_id])
  #     @trips = driver.trips
  #   elsif params[:passenger_id]
  #     passenger = Passenger.find_by(id: params[:passenger_id]) 
  #     @trips = passenger.trips
  #   else
  #     # This is the 'regular' route, /trips
  #     @trips = Trip.all
  #   end
  # end

  def show # details of an instance of an object

    if params[:id]
      # Look up the trip by trip id
      @trip = Trip.find_by(id: params[:id])
      if @trip.nil?
        redirect_to root_path
        return
      end
      # find driver and passenger with trip
      @driver = @trip.driver
      @passenger = @trip.passenger
    else
      redirect_to root_path
      return
    end
  end

  def create
    driver = Driver.find_by(available: true)
    passenger = Passenger.find_by(id: params[:passenger_id])
    @trip = Trip.create(
      driver_id: driver.id,
      passenger_id: passenger.id,
      date: Time.now,
      rating: nil,
      cost: rand(1..1000)
    )
    redirect_to passenger_path(passenger.id)
      return
  end
    
end
