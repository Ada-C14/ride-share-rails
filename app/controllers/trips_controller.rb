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

  end

  def update

  end

  def destroy

  end

end
private
def trip_params
  return params.require(:trip).permit(:driver_id, :passenger_id, :date, :rating, :cost)
end