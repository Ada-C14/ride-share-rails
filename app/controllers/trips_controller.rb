class TripsController < ApplicationController
  def index
      @trips = Trip.all
  end

  def show
    trip_id = params[:id].to_i
    @trip = Trip.find_by(id: trip_id)
    @driver = @trip.driver


    if @trip.nil?
      head :not_found
      # render :not_found, status: :not_found -->> WE CAN RENDER A TEMPLATE PAGE
    end

    @trips = @driver.trips if @driver
  end

  def new
    @trip = Trip.new
  end

  def create
    @trip = Trip.new(trip_params)

    if @trip.save
      redirect_to trip_path(@trip.id)
    else
      render :new
    end
  end

  def edit
    @trip = Trip.find_by(id: params[:id])
    if @trip.nil?
      redirect_to root_path
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
      render :edit
      return
    end
  end

  def destroy
    @trip = Trip.find_by(id: params[:id])
    if @trip
      @trip.destroy
      redirect_to root_path
    else
      head :not_found
      return
    end
  end

  def request_trip
    passenger = Passenger.find_by(id: params[:passenger_id])
    @trip = passenger.request_trip
    render :new
  end

  private
  def trip_params
    return params.require(:trip).permit(:driver_id, :passenger_id, :date, :rating, :cost, :cost_in_dollars)
  end
end


