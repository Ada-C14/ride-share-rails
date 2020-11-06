class TripsController < ApplicationController
  # Helper Methods
  def not_found_error_notice
    flash[:notice] = "Uh oh! That trip does not exist..."
    redirect_to trips_path
  end

  def not_saved_error_notice
    flash[:notice] = "Uh oh! That did not save correctly."
  end

  def no_available_driver_notice
    flash[:notice] = "There are currently no available drivers.
                      Please wait for a driver to become available and request again."
    redirect_to passenger_path(params[:passenger_id])
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
      @trips = Trip.order(:date).page(params[:page])
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
        driver_id: Trip.assign_driver,
        passenger_id: params[:passenger_id].to_i,
        date: Time.now,
        rating: nil,
        cost: Trip.generate_cost
    }

    if create_params[:driver_id].nil?
      no_available_driver_notice
      return
    end

    @trip = Trip.new(create_params)

    if @trip.save
      @trip.change_driver_status
      redirect_to trip_path(@trip.id)
      return
    else
      redirect_to passenger_path(params[:passenger_id])
      return
    end
  end

  def edit
    trip_id = params[:id].to_i
    @trip = Trip.find_by(id: trip_id)

    if @trip.nil?
      not_found_error_notice
      return
    end
  end

  def update
    @trip = Trip.find_by(id: params[:id])

    if @trip.nil?
      not_found_error_notice
      return
    else
      @trip.update(trip_params)
    end

    unless @trip.valid?
      render :edit
      return
    end

    redirect_to trip_path(@trip.id)
    return
  end

  def destroy
    @trip = Trip.find_by(id: params[:id])

    if @trip.nil?
      not_found_error_notice
      return
    else
      @trip.destroy
    end

    redirect_to trips_path
    return
  end

  private

  def trip_params
    return params.require(:trip).permit(:driver_id, :passenger_id, :date, :rating, :cost)
  end

end
