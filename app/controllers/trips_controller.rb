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
    @trip = Trip.new(passenger_id: params[:trip][:passenger_id], driver_id: params[:trip][:driver_id],
                     cost: params[:trip][:cost], rating: params[:trip][:rating], date: params[:trip][:date])
    if @trip.save
      redirect_to trip_path @trip.id# not sure about this redirection
      return
    else
      render :new, status: :bad_request
      return
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

  def request_trip
    passenger = Passenger.find_by(id: params[:passenger_id])
    @trip = passenger.request_trip
    render :new
  end
end
