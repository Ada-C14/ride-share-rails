class TripsController < ApplicationController
  def index
    @trips = Trip.all
  end

  def show
    @trip = Trip.find_by(id: params[:id])

    if @trip.nil?
      redirect_to trip_path
      return
    end
  end

  def new
    @trip = Trip.new
  end

end
