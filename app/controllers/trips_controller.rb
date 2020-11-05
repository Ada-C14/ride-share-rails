class TripsController < ApplicationController

  def index
    @trips = Trip.all
  end

  def show
    trip_id = params[:id].to_i
    @trip= Trip.find_by(id: trip_id)

    if @trip.nil?
      redirect_to trips_path
      return
    end
  end

  def new
    @trip = Trip.new
  end

  def create
    @trip = Trip.new(trip_params)

    if @trip.save
      redirect_to trip_path(@trip.id)
    else
      render :new, status: :bad_request
      return
    end
  end

  def edit
    @trip= Trip.find_by(id: params[:id])

    if @trip.nil?
      redirect_to trips_path
      return
    end
  end

  def update
    @trip= Trip.find_by(id: params[:id])

    if @trip.nil?
      redirect_to trips_path
      return
    elsif @trip.update(trip_params)
      redirect_to trips_path
      return
    else
      render :edit, status: :bad_request
      return
    end
  end

  def destroy
    @trip= Trip.find_by(id: params[:id])

    if @trip.nil?
      redirect_to trips_path
      return
    end
    @trip.destroy

    redirect_to trips_path
    return
  end

  private

  def trip_params
    return params.require(:trip).permit(:date, :rating, :cost)
  end

end
