class TripsController < ApplicationController

  def show
    @trip = Trip.find_by(id: params[:id])

    if @trip.nil?
      head :not_found
      return
    end

  end


  def create
    @passenger = Passenger.find_by(id: params[:passenger_id])
    @driver = Driver.get_available_driver
    @trip = Trip.request_trip(@driver, @passenger)

    if @trip.save
      redirect_to passenger_path(@trip.passenger)
      @driver.set_unavailable
      return
    else
      render :bad_request
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
    else
      if @trip.update(trip_params)
        # redirecting to passenger details page
        @trip.complete_trip
        redirect_to trip_path(@trip)
        return
      else
        render :edit, status: :bad_request
        return
      end
    end

  end

  def destroy
    trip = Trip.find_by(id: params[:id])

    if trip.nil?
      head :not_found
      return
    else
      trip.destroy
      redirect_to passenger_path(trip.passenger)
    end

  end

  private

  def trip_params
    return params.require(:trip).permit(:date, :driver_id, :passenger_id, :rating, :cost)
  end
end
