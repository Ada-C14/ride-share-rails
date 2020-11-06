class TripsController < ApplicationController

  def show
    if params[:passenger_id]
      passenger = Passenger.find_by(id: params[:passenger_id])
      @passenger = passenger.trips
    else
      trip_id = params[:id].to_i
      @trip = Trip.find_by(id: trip_id)
      if @trip.nil?
        redirect_to trips_path
        return
      end
    end
  end

  def create
    passenger = Passenger.find_by(id: params[:passenger_id])
    redirect_to passenger_path(params[:passenger_id]) if passenger.request_trip == 'in progress'

    if passenger.nil?
      redirect_to passengers_path
      return
    else
      driver = Driver.find_by(available: true)
      driver.mark_available

      @trip = Trip.new(
          passenger_id: passenger.id,
          driver_id: driver.id,
          cost: rand(1000..9000),
          date: Time.now,
          rating: nil
      )
    end

    if @trip.save
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
      redirect_to trip_path(@trip.id)
      return
    else
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
