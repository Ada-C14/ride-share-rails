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

  def create
    passenger = Passenger.find_by(id: params[:passenger_id])

    if passenger.nil?
      redirect_to passengers_path
      return
    else
      # nested route, /passenger/:passenger_id/trips/create
      driver = Driver.find_available_driver
      # @trip = passenger.trips.new
      @trip = Trip.new(
          passenger_id: passenger.id,
          driver_id: driver.id,
          cost: rand(1000..9000),
          rating: nil
      )
    end

    if @trip.save
      redirect_to trips_path(@trip.id) #send the user to the /tasks path
      return
    else
      # render :new, status: :bad_request
      redirect_to passenger_path(passenger.id)
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
