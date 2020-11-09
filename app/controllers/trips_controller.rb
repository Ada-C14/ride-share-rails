require 'date'

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

  def new
    @trip = Trip.new
  end

  def create
    @driver = Driver.find_by(available: true)
    @passenger = Passenger.find_by(id: params[:passenger_id])

    @trip = Trip.new(
        driver_id: @driver.id,
        passenger_id: @passenger.id,
        cost: rand(100..99999),
        date: Date.today, 
        rating: nil
    )
    @trip.save
    @driver.mark_unavailable

    if @trip.save
      redirect_to trip_path(@trip.id)
    else 
      flash.now[:error] = "Something happened. Trip not requested."
      redirect_to passenger_path(@passenger.id)
    end 

  end

  def edit
    @trip = Trip.find_by(id: params[:id])
    if @trip.nil?
      render :edit
      return
    end
  end


  def update
    @trip = Trip.find_by(id: params[:id])
    if @trip.nil?
      head :not_found
      return
    elsif @trip.update(trip_params)
      flash[:success] = "Trip updated successfully"
      redirect_to trip_path # go to the show so we can see the trip
      return
    else # save failed :(
      flash.now[:error] = "Something happened. Trip not updated."
      render :edit, status: :bad_request # show the new Trip form view again
      return
    end
  end

  def destroy
    @trip = Trip.find_by(id: params[:id])
    if @trip.nil?
      redirect_to root_path
      return
    else
      @trip.destroy
      redirect_to root_path
    end
  end

end

private

def trip_params
  return params.require(:trip).permit(:driver_id, :passenger_id, :rating, :date, :cost)
end

