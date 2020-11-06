class TripsController < ApplicationController
  def index
    @trips = Trip.order(:id)
  end

  def new
    @trip = Trip.new
  end

  def first_available_driver
    return Driver.find_by(available: true)
  end

  def create
    driver= first_available_driver
    @trip = Trip.new(passenger_id: params[:trip][:passenger_id], driver_id: driver.id, date: Date.today, rating: nil, cost: rand(1000...10000) )

    if @trip.save
      driver.available = false
      driver.save
      redirect_to trip_path(@trip.id)
      return
    else
      render :new
    end
  end

  def show
    @trip = Trip.find_by(id: params[:id])

    if @trip.nil?
      redirect_to trips_path
      return
    end
  end

  def edit
    @trip = Trip.find_by(id: params[:id])

    if @trip.nil?
      head :not_found
      return
    end
  end

  def update
    @trip = Trip.find_by(id: params[:id])

    if @trip.nil?
      head :not_found
      return
    elsif @trip.update(trip_params)
      redirect_to trip_path(@trip.id)
      return
    else
      render :edit
      return
    end
  end

  def destroy
    @trip = Trip.find_by(id: params[:id])

    if @trip.nil?
      head :not_found
      return
    elsif @trip.destroy
      redirect_to trips_path
      return
    end
  end

  private

  def trip_params
    return params.require(:trip).permit(:driver_id, :passenger_id, :date, :cost, :rating)
  end

end
