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
    driver = Driver.find_by(available: true)

    if driver
      passenger = Passenger.find_by(id: params[:passenger_id])
      @trip = Trip.new(driver_id: driver.id, passenger_id: passenger.id, cost:rand(1000..4999), date:Date.today)
      if @trip.save
        flash[:notice] = "Your Driver is On the Way! Current Location: Moon. Estimate Wait Time : 63 Days 2 Hours and 23 minutes."
        driver.update_attribute(:available, false)

        redirect_to trip_path(@trip.id)
      else
        redirect_to trips_path
        # render :new, status: :bad_request
        return
      end
    else
      flash[:notice] = "No driver is currently available. Please try again later!"
      redirect_to homepages_path
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
      redirect_to trip_path
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

    redirect_to passenger_path(id:params[:id])
    return
  end

  private

  def trip_params
    return params.require(:trip).permit( :date, :rating, :cost)
  end

end
