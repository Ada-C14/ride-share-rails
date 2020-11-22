class TripsController < ApplicationController
  def index
    @trips = Trip.all
  end

  def new
    @trip = Trip.new
  end

  def show
    trip_id = params[:id]
    @trip = Trip.find_by(id: trip_id)
    if @trip.nil?
      redirect_to trips_path
      return
    end
  end

  def create
    first_available_driver = Driver.where(available: true).first
    passenger = Passenger.find_by(id: params[:passenger_id])

    if passenger.nil?
      redirect_to root_path
      return
    end

    @trip = Trip.new(passenger_id: params[:passenger_id], driver_id: first_available_driver.id, date: Date.today, cost: rand(500...2500), rating: nil)

    if @trip.save # save returns true if the database insert succeeds
      first_available_driver.update_attribute(:available, false)
      redirect_to trip_path(@trip)
      return
    else
      redirect_to root_path
      return
    end
  end

  def edit
    trip_id = params[:id]
    @trip = Trip.find_by(id: trip_id)

    if @trip.nil?
      redirect_to trip_path
      return
    end
  end

  def update
    trip_id = params[:id]
    @trip = Trip.find_by(id: trip_id)

    if @trip.nil?
      redirect_to trip_path
      return
    elsif @trip.update(trip_params)
      redirect_to trips_path # go to the index so we can see the book in the list
      return
    else
      # save failed :(
      render :edit # show the new book form view again
      return
    end
  end

  def destroy
    trip_id = params[:id]
    @trip = Trip.find_by(id: trip_id)
    @trip.destroy
    redirect_to trips_path
  end

  def find_by_id
    trip_id = params[:id].to_i
    trip = Trip.find_by(id: trip_id)
  end


  private

  def trip_params
    return params.require(:trip).permit(:driver_id, :passenger_id, :date, :rating, :cost)
  end

end
