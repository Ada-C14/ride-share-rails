class TripsController < ApplicationController
  def homepage
    
  end

  def index
    if params[:passenger_id]
      passenger = Passenger.find_by(id: params[:passenger_id])
      @trips = passenger.trips
    elsif params[:driver_id]
      driver = Driver.find_by(id: params[:driver_id])
      @trips = driver.trips
    else
      @trips = Trip.all
    end

    @total_cost = 0
    @trips.each do |trip|
      @total_cost += trip.cost
    end
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
    # Want to use passenger id to create trip
    passenger = Passenger.find_by(id:passenger_id)
    if passenger.nil?
      head :not_found
      return
    end

    # Want to select available driver
    driver = Driver.find_by(available: true)
    if driver.nil?
      head :not_found
      return
    end

    # Will create an ID when saved
    # Create new trip with these params
    @trip = Trip.new(
        date: Date.today.to_s,
        rating:nil,
        cost: rand(500..5000),
        driver_id: driver.id,
        passenger_id: passenger.id
    )

    if @trip.save
      driver().save
      redirect_to passenger_path(passenger.id)
    else
      # head :not_found
      redirect_to redirect passenger_path(passenger.id)
    end
  end

  def edit
    # @trip = Trip.find_by(id: params[:id])
    # if @trip.nil?
    #   redirect_to passenger_trips_path(@passengers.id)
    #   return
    # end
  end

  def update

  end

  def destroy

  end
end
