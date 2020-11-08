class TripsController < ApplicationController

  before_action :find_trip, except: [:index, :new, :create]

  def index
    @trips = Trip.all.order(:date)
  end


  def show
    if @trip.nil?
      head :not_found
      return
    end
  end

  #do i need this method? bc only passenger can do that?
  def new
    @trip = Trip.new
  end

  def create
    driver = Driver.find_by(available: true)

    if params[:passenger_id].nil?
      head :not_found
    end

    new_trip = Trip.new(
                       date: Time.now,
                       cost: rand(2000..10000),
                       passenger_id: params[:passenger_id],
                       driver: driver,
                       rating: nil
                     )
    if new_trip.save
      redirect_to passenger_path(params[:passenger_id]) #trip_path(new_trip.id)
    else
      redirect_to passenger_path(params[:passenger_id])   #passsenger show page
    end
  end

  # need edit and show page for trips

  def edit
    if @trip.nil?
      head :not_found
      return
    end
  end

  def update
    # @trip = Trip.find_by(id: params[:id])
    if @trip.nil?
      head :not_found
      return
    end

    @trip.update(trip_params)
    redirect_to trip_path(@trip.id)

  end

  #if we delete driver, will it delete trip so that passenger cant access it
  def destroy
    @trip = Trip.find_by(id: params[:id])
    pp @trip

    if @trip.nil?
      head :not_found
      return
    end

    if @trip
      @trip.destroy
      redirect_to root_path
    end
  end

  private

  def find_trip
    @trip = Trip.find_by(id: params[:id])
  end

  def trip_params
    params.require(:trip).permit(:date, :rating, :cost, :driver_id, :passenger_id)
  end
end
