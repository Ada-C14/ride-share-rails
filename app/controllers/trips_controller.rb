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
      @trip = Trip.new
      @trip.date = Date.today
      @trip.driver = driver
      @trip.passenger_id = params[:passenger_id]
      @trip.rating = nil
      @trip.cost = rand(9999)

      if @trip.save
        redirect_to passenger_path(params[:passenger_id])
        return
      else
        redirect_to passenger_path(params[:passenger_id]), status: :bad_request
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

    if @trip.nil?
      head :not_found
      return
    else
      passenger_id = @trip.passenger.id
      @trip.destroy
      redirect_to passenger_path(passenger_id)
      return
    end
  end
end
