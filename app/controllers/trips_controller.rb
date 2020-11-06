class TripsController < ApplicationController
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
  end

  def show
    @trip = Trip.find_by(id: params[:id])

    if @trip.nil?
      redirect_to root_path
      return
    end
  end

  def create
    passenger = Passenger.find_by(id: params[:passenger_id])
    driver = Driver.find_by(available: true)

    @trip = passenger.trips.new(
        date: Date.today.to_s,
        rating: nil,
        cost: rand(1000..3000),
        passenger_id: passenger.id,
        driver_id: driver.id
        )

    if @trip.save
      @trip.driver.available = false
      @trip.driver.save
      redirect_to passenger_path(passenger.id)
    else
      redirect_to passenger_path(passenger.id), status: :bad_request
    end
  end

  def edit
    @trip = Trip.find_by(id: params[:id])

    if @trip.nil?
      redirect_to root_path
      return
    end
  end

  def update
    @trip = Trip.find_by(id: params[:id])

    if @trip.nil?
      head :not_found
      return
    # Try to DRY this block
    elsif params[:trip][:rating].nil? && @trip.update(rating: params[:trip][:rating])
      redirect_to trip_path(@trip.id)
      return
    elsif @trip.update(rating: params[:trip][:rating])
      @trip.driver.update(available: true)
      redirect_to trip_path(@trip.id)
      return
    else
      render :edit, status: :bad_request
      return
    end
  end

  def destroy
    @trip = Trip.find_by(id: params[:id])

    if @trip.nil?
      head :not_found
      return
    elsif @trip.rating
      @trip.destroy
      redirect_to passenger_path(@trip.passenger)
      return
    else
      render :edit, status: :bad_request
    end
  end

end
