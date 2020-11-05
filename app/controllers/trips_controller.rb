class TripsController < ApplicationController
  def index
    if params[:passenger_id]
      passenger = Passenger.find_by(id: params[:passenger_id])
      @trips = passenger.trips
    elsif params[:driver_id]
      driver = Driver.find_by(id: params[:driver_id])
      @trips = driver.trips
    else
      @trips = Trip.all
    end
  end

  def show
    @trip = Trip.find_by(id: params[:id])

    if @trip.nil?
      redirect_to root_path
      return
    end
  end

  def new
    # if params[:passenger_id]
    #   passenger = Passenger.find_by(id: params[:passenger_id])
    #   @trip = passenger.trips.new
    # elsif params[:driver_id]
    #   driver = Driver.find_by(id: params[:driver_id])
    #   @trip = driver.trips.new
    # else
      @trip = Trip.new
    # end
  end

  def create
    passenger = Passenger.find_by(id: params[:passenger_id])
    @trip = passenger.trips.new(
        driver_id: Driver.find_by(available: true),
        cost: rand(1000..9000),
        rating: nil )

    if @trip.save
      @trip.driver.available = false
      @trip.driver.save
      redirect_to passenger_path(passenger.id) #send to index
    else
      redirect_to passenger_path(passenger.id), status: :bad_request
    end
  end

end
