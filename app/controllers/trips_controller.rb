class TripsController < ApplicationController

  def index
    @trips = Trip.all
  end

  def show
    trip_id = params[:id].to_i
    @trips = Trip.find_by(id: trip_id)
    if @trips.nil?
      head :not_found
      return
    end
  end

end
