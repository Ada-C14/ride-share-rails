class TripsController < ApplicationController

  before_action :find_trip, except: [:index, :new, :create]

  def index
    @trips = Driver.all.order(:date)
  end

  def show
    if @trips.nil?
      redirect_to trips_path
      return
    end
  end

  def new
    @trip = Trip.new
  end

  def create
    @trip = Trip.new(trip_params)

    # save returns true if the database insert succeeds
    if @trip.save
      # go to the index so we can see the trip in the list, send them back to '/trips' path
      redirect_to trip_path(@trip.id)
      return
    else
    render :new, :bad_request
    return
    end
  end

  def edit
    if @trip.nil?
      redirect_to edit_trip_path
      # we can redirect to drivers_path index
      # or back to edit with friendly error message
      return
    end
  end

  def update

  end

  def destroy

  end

  private

  def find_trip
    @trip = Trip.find_by(id: params[:id])
  end

  def trip_params
    return params.require(:trip).permit(:date, :rating, :cost, :driver_id, :passenger_id)
  end
end
