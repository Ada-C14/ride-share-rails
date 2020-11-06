class TripsController < ApplicationController
  def homepage
    
  end


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

    @total_cost = 0
    @trips.each do |trip|
      @total_cost += trip.cost
    end
  end


  def show
    trip_id = params[:id].to_i
    @trip = Trip.find_by(id:trip_id)

    if @trip.nil?
      head :not_found
      return
    end
  end

  def new

  end

  def create
    @trip = Trip.new()

  end

  def edit

  end

  def update

  end

  def destroy

  end
end
