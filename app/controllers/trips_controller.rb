class TripsController < ApplicationController

  def index
    # if !params[:driver_id].nil?
    #   @trips = Driver.find_by(id: params[:@driver_id])
    # elsif !params[:passenger_id].nil?
    #   @trips = Passenger.find_by(id: params[:@passenger_id]).trips
    # else
      @trips = Trip.all
    # end
  end

  def show
    trip_id = params[:id].to_i
    @trip = Trip.find_by(id: trip_id)

    if @trip.nil?
      head :not_found
      return
    end
  end
  
  def create
    @trip = Trip.new(trip_params)

    if @trip.save
      redirect_to trip_path(@trip)
    else
      redirect_to new_trip_path
    end
  end

  def edit
    @trip = find_by_id

    if @trip.nil?
      redirect_to trips_path
      return
    end
  end

  def update
    @trip = find_by_id

    if @trip.nil?
      head :not_found
      return
    elsif @trip.update(trip_params)
      redirect_to trip_path(@trip)
      return
    else
      render :bad_request
      return
    end
  end

  def destroy
    @trip = find_by_id

    if @trip.nil?
      head :not_found
      return
    else
      @trip.destroy
      redirect_to homepages_path
    end
  end

  def find_by_id
    trip_id = params[:id].to_i
    trip = Trip.find_by(id: trip_id)
  end

  private

  def trip_params
    return params.require(:trip).permit(:cost, :rating, :date, :driver_id, :passenger_id)
  end
end
