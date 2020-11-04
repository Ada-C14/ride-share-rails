class TripsController < ApplicationController

  def show
    @trip_id = params[:id].to_i
    @trip = Trip.find(@trip_id)
    if @trip.nil?
      redirect_to trips_path
      return
    end
  end

  def new
  end

  def create
  end

  def edit
    @trip = Trip.find_by(id: params[:id])
    if @trip.nil?
      redirect_to root_path
      return
    end
  end

  def update
  end

  def destroy
    trip = Trip.find_by(id: params[:id])

    if trip.nil?
      head :not_found
      return
    else
      trip.destroy
      redirect_to trips_path
    end
  end

  private

  def trip_params
  end


end
