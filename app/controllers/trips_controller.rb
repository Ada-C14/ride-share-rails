class TripsController < ApplicationController
  def index
    @trips = Trip.all
  end

  def show
    trip_id = params[:id].to_i
    @trip = Trip.find_by(id: trip_id)

    if @trip.nil?
      head :not_found
      # render :not_found, status: :not_found -->> WE CAN RENDER A TEMPLATE PAGE
    end
    # @trips = @driver.trip_list
  end

  def new
    @trip = Trip.new
  end

  def create

  end

  def edit

  end

  def update

  end

  def destroy

  end
end
