class TripsController < ApplicationController
  def index
      @trips = Trip.all
  end

  def show
    trip_id = params[:id].to_i
    @trip = Trip.find_by(id: trip_id)

    if @trip.nil?
      head :not_found
      # render :not_found, status: :not_found -->> WE CAN RENDER A TEMPLATE PAGE
      return
    end

    @driver = @trip.driver
    @trips = @driver.trips if @driver
  end

  def new
    # Found the passenger that will be assigned to the "new trip"
    passenger = Passenger.find_by(id: params[:passenger_id])
    # Making a new trip using a class helper method
    @trip = Trip.request_trip(passenger)
  end

  def create
    @trip = Trip.new(trip_params)
    available_driver = Driver.find_by_id(@trip.driver_id)
    if @trip.save
      available_driver.update({available: false})
      redirect_to trip_path(@trip.id)
    else
      redirect_to trips_path
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
    end
    unless @trip.update(trip_params)
      render :edit
      return
    end
    if @trip.rating
      @trip.driver.available = true
      @trip.driver.save
    end
    redirect_to trip_path
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

  # def request_trip
  #   passenger = Passenger.find_by(id: params[:passenger_id])
  #   @trip = passenger.request_trip
  #   render :new
  # end

  private
  def trip_params
    return params.require(:trip).permit(:driver_id, :passenger_id, :date, :rating, :cost, :cost_in_dollars)
  end
end


