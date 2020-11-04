class TripsController < ApplicationController

  def show
    @trip = Trip.find_by(id: params[:id])

    if @trip.nil?
      head :not_found
      return
    end

  end

  def create
    trip = Trip.new(trip_params)

    if trip.save
      # where should we redirect to?
      redirect_to trip_path(trip.id)
      return
    else
      # what should we render now that we don't have new view?
      render :bad_request
      return
    end

  end

  def edit
    @trip = Trip.find_by(id: params[:id])
  end

  def update

    trip = trip.find_by(id: params[:id])

    if trip.nil?
      # where should this lead to?
      redirect_to root_path
    else
      if trip.update(trip_params)
        # redirecting to passenger details page
        redirect_to passenger_path(passenger.id)
        return
      else
        render :edit, :bad_request
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
      redirect_to passenger_path(passenger.id)
    end

  end

  private

  def trip_params
    return params.require(:trip).permit(:date, :driver_id, :passenger_id, :rating, :cost)
  end
end
