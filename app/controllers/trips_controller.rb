class TripsController < ApplicationController
  def index
    @trips = Trip.all
  end

  def show
    trip_id = params[:id]

    begin
      @trip = Trip.find(trip_id)
    rescue ActiveRecord::RecordNotFound
      @trip = nil
    end

    if @trip.nil?
      head :not_found
      return
    end
  end

  def new
    @trip = Trip.new
  end


  def create
    @passenger = Passenger.find_by(id: params[:passenger_id])
    @driver = Driver.find_by(available: true)
    @cost = rand(1..1000)
    @date = Time.now.strftime("%Y/%m/%d")
    @rating = nil
    @trip = Trip.new(
        driver_id: @driver.id,
        passenger_id: @passenger.id,
        rating: @rating,
        cost: @cost,
        date: @date)

    if @trip.save
      @driver.available = false
      @driver.save
      redirect_to trip_path @trip.id
      return
    else
      redirect_to passenger_path @passenger.id
    end
  end

  def edit
    @trip = Trip.find_by(id: params[:id])
    trip_id = params[:id]

    begin
      @trip = Trip.find(trip_id)
    rescue ActiveRecord::RecordNotFound
      @trip = nil
    end

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
    elsif @trip.update(
        passenger_id: params[:trip][:passenger_id], driver_id: params[:trip][:driver_id],
        cost: params[:trip][:cost], rating: params[:trip][:rating], date: params[:trip][:date] )
      redirect_to trip_path(@trip.id)
      return
    else # save failed
    render :edit
    return
    end
  end

  def destroy
    trip_id = params[:id]
    @trip = Trip.find_by(id: trip_id)

    if @trip
      @trip.destroy
      redirect_to trips_path
      return
    else
      head :not_found
      return
    end
  end

  # def trip_params
  # trip_params = (passenger_id: params[:trip][:passenger_id], driver_id: params[:trip][:driver_id],
  #         cost: params[:trip][:cost], rating: params[:trip][:rating], date: params[:trip][:date] )
  # end
  #
  # def request_trip
  #   passenger = Passenger.find_by(id: params[:passenger_id])
  #   @trip = passenger.request_trip
  #   render :new
  # end
  #
  #  def dollar_format
  #     dollars = number_to_currency(@trip.cost/100)
  #     return dollars
  #   end
end
