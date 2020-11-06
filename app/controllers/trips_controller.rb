class TripsController < ApplicationController
  def homepage
    
  end


  def index
    @drivers = Driver.all
    @passengers = Passenger.all
    @trips = Trip.all
  end

  def show
    trip_id = params[:id].to_i
    @trip = Trip.find_by(id:trip_id)

    if @trip.nil?
      head :not_found
      return
    end
  end

  def new

  end

  def create
    @trip = Trip.new()

  end

  def edit

  end

  def update

  end

  def destroy

  end
end
