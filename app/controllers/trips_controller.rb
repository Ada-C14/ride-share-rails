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

    available_driver = nil
    @drivers.each do |driver|
      if driver.available == true
        break if available_driver = driver
      end
    end

    if available_driver.nil?
      head :not_found
      return
    end

    if params[:passenger_id]
      passenger = Passenger.find_by(id: params[:passenger_id])
      if passenger.nil?
        head :not_found
        return
      else
        pass_id = passenger.id
      end
    end

    @trip = Trip.new(date: Time.now, rating: nil, cost: rand(1000..3500), driver_id: available_driver.id, passenger_id: pass_id)

    if @trip.save
      available_driver.update(available: false)
      redirect_to passenger_path(params[:passenger_id])
      return
    else
      redirect_to passenger_path(params[:passenger_id])
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
    elsif @trip.update(trip_params)
      redirect_to trip_path(id: @trip[:id])
      return
    else
      render :edit, status: :bad_request  
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
