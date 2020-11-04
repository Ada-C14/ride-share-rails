class TripsController < ApplicationController

  def index
    @trips = Trip.all
  end

  def show
    trip_id = params[:id].to_i
    @trip= Trip.find_by(id: Trip_id)

    if@trip.nil?
      redirect_to Trips_path
      return
    end
  end

  def new
    @trip= Trip.new
  end

  def create
    @trip= Trip.new(Trip_params)

    if @trip.save
      redirect_to Trip_path(@trip.id)
    end
  end

  def edit
    @trip= Trip.find_by(id: params[:id])

    if@trip.nil?
      redirect_to Trips_path
      return
    end
  end

  def update
    @trip= Trip.find_by(id: params[:id])

    if@trip.nil?
      redirect_to Trips_path
      return
    elsif@trip.update(Trip_params)
      redirect_to Trips_path
      return
    else
      render :edit
      return
    end
  end

  def destroy
    @trip= Trip.find_by(id: params[:id])

    if@trip.nil?
      redirect_to Trips_path
      return
    end
    @trip.destroy

    redirect_to Trips_path
    return
  end

  private

  def Trip_params
    return params.require(:Trip).permit(:id, :name, :vin, :available)
  end

end
