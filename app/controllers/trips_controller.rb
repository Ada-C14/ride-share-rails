class TripsController < ApplicationController
  def index
    @trips = Trip.all
  end

  def new
    @trip = Trip.new
  end

  def show
    trip_id = params[:id]
    @trip = Trip.find_by(id: trip_id)
    if @trip.nil?
      redirect_to trips_path
      return
    end
  end

  def create
    @trip = Trip.new(trip_params)
    if @trip.save # save returns true if the database insert succeeds
      redirect_to trip_path(@trip.id)
      return
    else
      render :new
      return
    end
  end

  def edit
    trip_id = params[:id]
    @trip = Trip.find_by(id: trip_id)

    if @trip.nil?
      redirect_to trip_path
      return
    end
  end

  def update
    trip_id = params[:id]
    @trip = Trip.find_by(id: trip_id)

    if @trip.nil?
      redirect_to trip_path
      return
    elsif @trip.update(trip_params)
      redirect_to trips_path # go to the index so we can see the book in the list
      return
    else
      # save failed :(
      render :edit # show the new book form view again
      return
    end
  end

  def destroy
    trip_id = params[:id]
    @trip = Trip.find_by(id: trip_id)
    @trip.destroy
    redirect_to trips_path
  end


  private

  def trip_params
    return params.require(:trip).permit(:driver_id, :passenger_id, :date, :rating, :cost)
  end

end
