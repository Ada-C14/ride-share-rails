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
    if @passenger.nil? || @driver.nil?
      head :bad_request
      return
    end

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
    @drivers = Driver.order(:name)
    @passengers = Passenger.order(:name)

    if @trip.nil?
      head :not_found
      return
    end
  end

  def update
    @trip = Trip.find_by(id: params[:id])
    @drivers = Driver.order(:name)
    @passengers = Passenger.order(:name)

    if @trip.nil?
      head :not_found
      return
    elsif @trip.update(trip_params)
      redirect_to trip_path(@trip.id)
      return
    else # save failed
    render :edit, status: :bad_request
    return
    end
  end

  def destroy
    trip_id = params[:id]
    @trip = Trip.find_by(id: trip_id)

    if @trip
      @trip.destroy
      redirect_to passengers_path
      return
    else
      head :not_found
      return
    end
  end

  private
  def trip_params
    params.require(:trip).permit(:passenger_id, :driver_id, :cost, :rating, :date)
  end

end
