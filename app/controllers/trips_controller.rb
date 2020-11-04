class TripsController < ApplicationController

  def show
    @trip = Trip.find_by(id: params[:id])

    if @trip.nil?
      head :not_found
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

  def create
    driver = Driver.select_driver

    if driver.nil?
      redirect_to passenger_path(params[:passenger_id])
    else
      @trip = Trip.new(
          passenger_id: params[:passenger_id],
          driver_id: driver.id,
          date: Date.today,
          cost: rand(5000),
          rating: nil
      )
      if @trip.save
        redirect_to passenger_path(params[:passenger_id])
      else
        render :new
      end
    end
  end

  def update
    @trip = Trip.find_by(id: params[:id])

    if @trip.nil?
      head :not_found
      return
    elsif
      @trip.update(rating: params[:trip][:rating])
      redirect_to trip_path
      return
    else
      render :edit
      return
    end
  end

  def destroy
    @trip = Trip.find_by(id: params[:id])
    passenger_id = @trip.passenger.id
    if @trip.nil?
      head :not_found
      return
    else
      @trip.destroy
      redirect_to passenger_path(passenger_id)
      return
    end
  end
end
