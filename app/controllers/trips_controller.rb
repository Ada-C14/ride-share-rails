class TripsController < ApplicationController
  def index
    if params[:driver_id]
      #nested route: prefix driver_trips (/drivers/:driver_id/trips)
      driver = Driver.find_by(id: params[:driver_id])
      @trips = driver.trips
    elsif params[:passenger_id]
      #nested route: prefix passenger_trips (/passengers/:passenger_id/trips)
      passenger = Passenger.find_by(id: params[:passenger_id])
      @trips = passenger.trips
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
    if params[:passenger_id]
      passenger = Passenger.find_by(id: params[:passenger_id])
      @trip = passenger.trips.new
    else
      @trip = Trip.new
    end
  end

  def create
    @trip = Trip.new(trip_params)
    #@trip = Trip.new(date: Date.today, cost: 1234, driver_id: params[:driver_id], passenger_id: params[:passenger_id])

    if @trip.save
      redirect_to trip_path(@trip) and return
    else
      render :new, status: :bad_request
      return
      # TODO
      # thoughts: do we want the user to be able to make trips
      # from the website? or should they only be creatable by a
      # user requesting a new trip? and, if that is the only way that
      # one will be created, shouldn't we not have a view page for trips#new?
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

    if @trip.nil?
      redirect_to trips_path and return
    elsif
      @trip.update(trip_params)
      redirect_to trip_path(@trip)
    else
      render :edit and return
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
    #return params.require(:trip).permit(:date, :cost, :passenger_id)
    #driver should be assigned, rating should not be entered when the trip is created
    return params.require(:trip).permit(:date, :rating, :cost, :driver_id, :passenger_id)
  end
end
