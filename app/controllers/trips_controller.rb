class TripsController < ApplicationController
  def show
    trip_id = params[:id].to_i
    @trip = Trip.find_by(id: trip_id)

    if @trip.nil?
      redirect_to trips_path
      return
    end

  end


  def create
    if params[:passenger_id].nil?
      @trip = Trip.new(trip_params)
    else
      passenger = Passenger.find_by_id(params[:passenger_id])
      @trip = passenger.request_trip
    end

    if @trip.save
      if params[:passenger_id].nil?
        redirect_to trip_path(@trip.id)
        return
      else
        redirect_to passenger_path(passenger.id)
        return
      end
    else
      redirect_to trips_path
      return
    end

  end

  def edit
    trip_id = params[:id]
    @trip = Trip.find_by(id: trip_id)

    if @trip.nil?
      redirect_to trips_path
      return
    end
  end

  def update
    trip_id = params[:id]
    @trip = Trip.find_by(id: trip_id)

    if @trip.nil?
      redirect_to trips_path
      return
    elsif @trip.update(trip_params)
      redirect_to trip_path(@trip.id)
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
    end

    if @trip.destroy
      redirect_to root_path
      return
    else #if .destroy fails
    redirect_to trip_path(@trip.id)
    return
    end
  end

  private

  def trip_params
    return params.require(:trip).permit(:driver_id, :passenger_id, :date, :rating, :cost)
  end
end
