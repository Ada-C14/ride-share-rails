class TripsController < ApplicationController
  # Helper Methods
  def not_found_error_notice
    flash[:notice] = "Uh oh! That trip does not exist..."
    redirect_to trips_path
  end

  def not_saved_error_notice
    flash[:notice] = "Uh oh! That did not save correctly."
  end

  #########################################################

  def index
    if params[:passenger_id]
      passenger = Passenger.find_by(id: params[:passenger_id])
      @trips = passenger.trips
    elsif params[:driver_id]
      driver = Driver.find_by(id: params[:driver_id])
      @trips = driver.trips
    else
      @trips = Trip.all
    end
  end

  def show
    trip_id = params[:id].to_i
    @trip = Trip.find_by(id: trip_id)

    if @trip.nil?
      not_found_error_notice
      return
    end
  end

  def create
    create_params = {
        trip: {
            driver_id: Trips.assign_driver,
            passenger_id: params[:passenger_id],
            date: Time.now.strftime("%m/%d/%Y"),
            rating: nil,
            cost: rand(8.0..35.0).round(2)
        }
    }

    @trip = Trip.new(create_params)

    if @trip.save
      redirect_to trip_path(@trip.id)
      return
    else
      render :new
      return
    end
  end

  private

  def trip_params
    return params.require(:trip).permit(:driver_id, :passenger_id, :date, :rating, :cost)
  end

end
