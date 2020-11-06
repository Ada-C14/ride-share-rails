class TripsController < ApplicationController

  def index
    if params[:passenger_id]
      passenger = Passenger.find_by(id: params[:passenger_id])
      @trips = passenger.trips
    else
      @trips = Trip.all
    end
  end

  def show
    @trip = find_trip

    redirect_to trips_path and return if @trip.nil?
  end

  def create
    passenger = Passenger.find_by(id: params[:passenger_id])

    #what if no drivers available?
    # redirect to page that says "no driver"?

    @trip = passenger.request_trip

    if @trip.save
      #make a new view
      redirect_to passenger_path(params[:passenger_id])
    else
      #display error message?
      redirect_to passengers_path
    end
  end

  def assign_rating
    trip = find_trip
    redirect_to trips_path and return if @trip.nil?

  end

  def edit
    @trip = find_trip

    redirect_to trips_path and return if @trip.nil?
  end

  def update
    trip = find_trip

    redirect_to trips_path and return if trip.nil?

    action_success_check(trip.update(trip_params), trip_path)
  end

  def destroy
    trip = find_trip

    redirect_to trips_path and return if trip.nil?

    action_success_check(trip.destroy, trips_path)
  end

  private

  def action_success_check(action, redirect_path)
    if action
      redirect_to redirect_path
    else
      render :new, bad_request
    end
  end

  def trip_params
    return params.require(:trip).permit(:date, :rating, :cost)
  end

  def find_trip
    return Trip.find_by(id: params[:id].to_i)
  end


end
