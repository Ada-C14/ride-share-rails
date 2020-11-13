class TripsController < ApplicationController
  def index
    @trips = Trip.all
  end

  def show
    @trip = Trip.find_by(id: params[:id])

    if @trip.nil?
      head :not_found
      return
    end

    @passenger = Passenger.find_by(id: @trip.passenger_id)
    @driver = Driver.find_by(id: @trip.driver_id)
  end

  def new
    @trip = Trip.new

    if params[:passenger_id]
      @trip = Trip.request_trip(params[:passenger_id])
      @trip.save
      @passenger = Passenger.find(@trip.passenger_id)
      @driver = Driver.find(@trip.driver_id)
      return
    else
      return
    end

  end

  def create
    @trip = Trip.new(trip_params)
    if @trip.date == nil || @trip.date == ""
      @trip.date = Date.today
    end

    if @trip.save
      redirect_to trip_path(@trip)
      return
    else
      render :new, status: :bad_request
      return
    end
  end

  def edit
    @trip = Trip.find_by(id: params[:id])

    if @trip.nil?
      head :not_found
      return "Trip not found"
    end
  end

  def update
    @trip = Trip.find_by(id: params[:id])
    if @trip.nil?
      head :not_found
      return "Trip not found"
    elsif @trip.update(trip_params)
      redirect_to trips_path
      return
    else
      render :edit, status: :bad_request
      return
    end
  end

  def destroy

    @trip = Trip.find_by(id: params[:id])

    if @trip.nil?
      head :not_found
      return
    end

    @trip.destroy

    redirect_to trips_path
    return
  end



  private

  def trip_params
    return params.require(:trip).permit(:driver_id, :passenger_id, :date, :rating, :cost)
  end
end
