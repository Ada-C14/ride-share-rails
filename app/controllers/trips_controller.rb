class TripsController < ApplicationController

  def index
    if params[:passenger_id]
      @passenger = Passenger.find_by(id: params[:passenger_id]) #key from url path
      @trips = @passenger.trips
    elsif params[:driver_id]
      @driver = Driver.find_by(id: params[:driver_id])
      @trips = @driver.trips
    else
      @trips = Trip.all
    end
  end

  def show
    @trip = Trip.find_by(id: params[:id])
    if @trip.nil?
      redirect_to trip_path
      return
    end
  end

  def new
    if params[:passenger_id]
      @passenger = Passenger.find_by(id: params[:passenger_id])
      @trip = @passenger.trips.new
    elsif params[:driver_id]
      @driver = Driver.find_by(id: params[:driver_id])
      @trip = @driver.trips.new
    else
      @trip = Trip.new
    end

  end

  def create
    @trip = Trip.new(trip_params)
    @trip[:cost] = rand(500..5000)
    @driver = Driver.find_by(id: @trip.driver_id)
    @passenger = Passenger.find_by(id: @trip.passenger_id)

      if @trip.save
        redirect_to trip_path(@trip.id)
        return
      else
        render :new
        return
      end
  end

  def edit
    @trip = Trip.find_by(id: params[:id])
    if @trip.nil?
      redirect_to trip_path
      return
    end

    if params[:passenger_id]
      @trip = Trip.find_by(id: params[:id])
      @passenger.trips.save
      redirect_to passenger_trips_path
      return
    elsif params[:driver_id]
      @trip.save
      redirect_to driver_trips_path
      return
    end
  end

  def update
    @trip = Trip.find_by(id: params[:id])

    if @trip.nil?
      redirect_to root_path
      return
    end

    result = @trip.update(trip_params)

    if result
      redirect_to root_path
      return
    end
  end

  def destroy
    @trip = Trip.find_by(id: params[:id])

    if @trip.nil?
      redirect_to root_path
      return
    else
      @trip.destroy
      redirect_to root_path
      return
    end
end

  private

  def trip_params
    return params.require(:trip).permit(:id, :driver_id, :passenger_id, :date, :rating, :cost)
  end
end
