class TripsController < ApplicationController
  def index
    if params[:driver_id]
      #nested route: prefix driver_trips (/drivers/:driver_id/trips)
      @driver = Driver.find_by(id: params[:driver_id])
      @trips = @driver.trips
    elsif params[:passenger_id]
      #nested route: prefix passenger_trips (/passengers/:passenger_id/trips)
      @passenger = Passenger.find_by(id: params[:passenger_id])
      @trips = @passenger.trips
    else
      @trips = Trip.all
    end
  end

  def show
    @trip = Trip.find_by(id: params[:id])

    if @trip.nil?
      redirect_to trips_path and return
    end
  end

  def new
  end

  def create
    driver = Driver.select_available #Driver.find_by(available: true)
    passenger = Passenger.find_by(id: params[:passenger_id])
    cost = rand(1000..9999)

    if passenger
      @trip = Trip.new(driver_id: driver.id, passenger_id: passenger.id, date: Date.today, cost: cost)
    else
      redirect_to trips_path
    end

    if @trip.save
      redirect_to trip_path(@trip) and return
    else
      driver.toggle_available
      redirect_to trips_path
      return
    end
  end

  def edit
    @trip = Trip.find_by(id: params[:id])

    if @trip.nil?
      redirect_to trips_path and return
    end
  end

  def update
    @trip = Trip.find_by(id: params[:id])
    passenger = Passenger.find_by(id: @trip.passenger_id)

    if @trip.nil?
      redirect_to trips_path and return
    elsif
      @trip.update(trip_params)
      passenger.complete_trip(@trip)
      redirect_to trip_path(@trip)
    else
      render :edit, status: :bad_request
    end
  end

  def destroy
    @trip = Trip.find_by(id: params[:id])

    if @trip
      @trip.destroy
      redirect_to trips_path and return
    else
      redirect_to trips_path and return
    end
  end

  private

  def trip_params
    #return params.require(:trip).permit(:date, :cost, :passenger_id, :driver_id)
    #driver should be assigned, rating should not be entered when the trip is created
    return params.require(:trip).permit(:date, :rating, :cost, :driver_id, :passenger_id)
  end
end
