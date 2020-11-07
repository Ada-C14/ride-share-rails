class TripsController < ApplicationController
    
  def show # details of an instance of an object

    if params[:id]
      # Look up the trip by trip id
      @trip = Trip.find_by(id: params[:id])
      if @trip.nil?
        redirect_to root_path
        return
      end
      # find driver and passenger with trip
      @driver = @trip.driver
      @passenger = @trip.passenger
    else
      redirect_to root_path
      return
    end
  end

  def create
    driver = Driver.find_by(available: true)
    driver.change_status
    passenger = Passenger.find_by(id: params[:passenger_id])
    if @trip = Trip.create(
      driver_id: driver.id,
      passenger_id: passenger.id,
      date: Time.now,
      rating: nil,
      cost: rand(1..1000)
    )
    driver.save
    redirect_to passenger_path(passenger.id)
    else # create failed
      render :new
      return
    end
  end

  def new 
    @trip = Trip.new 
  end

  def update
    if params[:id]
      @trip = Trip.find_by(id: params[:id])
      if @trip.nil?
        redirect_to root_path
        return
      elsif @trip.update(trip_params)# using strong params
          redirect_to trips_path
        return
      else # save failed
        render :edit
        return
      end
    end
  end

  def edit
    @trip = Trip.find_by(id: params[:id])
    if @trip.nil?
      redirect_to root_path
      return
    end
  end

  def destroy
    if params[:id]
      @trip = Trip.find_by(id: params[:id])
      if @trip.nil?
        redirect_to root_path
        return
      else
        @trip.destroy
        redirect_to root_path
      end
    end
  end
    
  private
    def trip_params
      return params.require(:trip).permit(:driver_id, :passenger_id, :passenger_id, :rating, :cost)
    end
  
end
