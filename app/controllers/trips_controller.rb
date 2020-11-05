class TripsController < ApplicationController

  def show
    if params[:passenger_id]
      passenger = Passenger.find_by(id: params[:passenger_id])
      @passenger = passenger.trips
    else
      @trip_id = params[:id].to_i
      @trip = Trip.find(@trip_id)
      if @trip.nil?
        redirect_to trips_path
        return
      end
    end
  end

  def new
    if params[:passenger_id]
      # nested route, /passenger/:passenger_id/trips/new
      passenger = Passenger.find_by(id: params[:passenger_id])
      @trip = passenger.trips.new
    else
      # route /trips/new
      @trip = Trip.new
    end
  end

  def create
    @trip = Trip.new(trip_params)
    if @trip.save
      redirect_to trips_path(@trip.id) #send the user to the /tasks path
      return
    else
      render :new, status: :bad_request
      return
    end
  end

  def edit
    @trip = Trip.find_by(id: params[:id])
    if @trip.nil?
      redirect_to root_path
      return
    end
  end

  def update
    @trip = Trip.find_by(id: params[:id])
    if @trip.nil?
      head :not_found
      return
    elsif @dtrip.update(trip_params)
      redirect_to trip_path(@trip.id)
      return
    else
      # render :edit
      redirect_to root_path
    end
  end

  def destroy
    trip = Trip.find_by(id: params[:id])

    if trip.nil?
      head :not_found
      return
    else
      trip.destroy
      redirect_to trips_path
    end
  end

  private

  def trip_params
    return params.require(:trip).permit(:date, :rating, :driver_id, :passenger_id, :cost)
  end
  
end
