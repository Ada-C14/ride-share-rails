class TripsController < ApplicationController

  def index
    if params[:passenger_id]
      passenger = Passenger.find_by(id: params[:passenger_id])
      @trips = passenger.trips
    elsif params[:driver_id]
      driver = Driver.find_by(id: params[:driver_id])
      @trips = driver.trips
    else
      head :not_found # for now
    end
  end

  def show
    @trip = Trip.find_by(id: params[:id])
    if @trip.nil?
      head :not_found
      return
    end
  end

  def new
    @trip = Trip.new
  end

  def create
    @drivers = Driver.all
    # change status to unavailable // similar to mark complete
    available_driver = ""
    @drivers.each do |driver|
      if driver.available == true
        available_driver = driver
      else
        render :not_found
      end
    end

    if params[:passenger_id]
      passenger = Passenger.find_by(id: params[:passenger_id])
      pass_id = passenger.id
    end

    @trip = Trip.new(date: Time.now, rating: nil, cost: rand(1000..3500), driver_id: available_driver.id, passenger_id: pass_id)
    if @trip.save
      redirect_to trips_path
      return
    else
      render :new
      return
    end
  end

  def edit
    @trip = Trip.find_by(id: params[:id])
    if @trip.nil?
      head :not_found
      return
    end
  end

  def update
    @trip = Trip.find_by(id: params[:id])
    if @trip.nil?
      head :not_found
      return
    elsif @trip.update(driver_params)
      redirect_to trip_path(id: @trip[:id])
      return
    else
      render :edit
      return
    end
  end

  def destroy
    @trip = Trip.find_by(id: params[:id])
    if @trip.nil?
      head :not_found
      return
    else
      @trip.destroy
      redirect_to root_path
      return
    end
  end

  private

  def trip_params
    return params.require(:trip).permit(:date, :rating, :cost)
  end
end
