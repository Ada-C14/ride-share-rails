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
  end

  def update
  end

  def destroy
  end

  private

  def trip_params
  end


end
