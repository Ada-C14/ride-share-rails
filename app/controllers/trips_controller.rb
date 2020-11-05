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
        driver_id: Driver.find_by(available: 'true').id,
        passenger_id: params[:passenger_id].to_i,
        date: Time.now,
        rating: nil,
        cost: rand(8.0..35.0).round(2)
    }

    @trip = Trip.new(create_params)

    if @trip.save
      driver = Driver.find_by(id: @trip.driver_id)
      driver.available = 'false'
      driver.save
      redirect_to trip_path(@trip.id)
      return
    else
      render :new
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
