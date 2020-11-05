class TripsController < ApplicationController

  before_action :find_trip, except: [:index, :new, :create]

  def index
    @trips = Trip.all.order(:date)
  end

  def show
    if @trip.nil?
      redirect_to root_path
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
      redirect_to trips_path
      return
    end
  end

  def update
    if @trip.nil?
      redirect_to trips_path
      return
    elsif @trip.update(trip_params)
      redirect_to trip_path(@trip.id)
      #stays on specific driver page to show update. Otherwise will have to find driver in list to see changes
      return
    else                # save failed
    render :edit      # show the new task form view again
    return
    end
  end

  #if wwe delete driver, will it delete trip so that passenger cant access it
  def destroy
    if @trip
      @trip.destroy
      redirect_to trips_path
    else
      head :not_found
    end

  end

  private

  def find_trip
    @trip = Trip.find_by(id: params[:id])
  end

  def trip_params
    return params.require(:trip).permit(:date, :rating, :cost, :driver_id, :passenger_id)
  end
end
