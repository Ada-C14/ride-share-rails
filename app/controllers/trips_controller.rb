class TripsController < ApplicationController
  def index
    if params[:driver_id]
      driver = Driver.find_by(id: params[:driver_id])
      @trips = driver.trips
    else
      @trips = Trip.all
    end
  end

  def show
    trip_id = params[:id].to_i
    @trip = Trip.find_by(id: trip_id)
    @driver = @trip.driver


    if @trip.nil?
      head :not_found
      # render :not_found, status: :not_found -->> WE CAN RENDER A TEMPLATE PAGE
    end

    @trips = @driver.trips if @driver
  end

  def new
    @trip = Trip.new
  end

  def create

  end

  def edit

  end

  def update

  end

  def destroy

  end
end
