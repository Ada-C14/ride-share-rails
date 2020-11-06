class TripsController < ApplicationController
  def show
    trip_id = params[:id].to_i
    @trip = Trip.find_by(id: trip_id)

    if @trip.nil?
      render file: "#{Rails.root}/public/404.html", status: :not_found
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

    if @trip.save && params[:passenger_id].nil?
      redirect_to trip_path(@trip.id)
      return
    else
      redirect_to passenger_path(passenger.id)
      return
    end

  end

  def edit
    trip_id = params[:id]
    @trip = Trip.find_by(id: trip_id)

    if @trip.nil?
      render file: "#{Rails.root}/public/404.html", status: :not_found
      return
    end
  end

  def update
    trip_id = params[:id]
    @trip = Trip.find_by(id: trip_id)

    if @trip.nil?
      render file: "#{Rails.root}/public/404.html", status: :not_found
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
      render file: "#{Rails.root}/public/404.html", status: :not_found
      return
    end

    if @trip.destroy
      if params[:passenger_id] && params[:driver_id].nil?
        redirect_to passenger_path(params[:passenger_id])
        return
      elsif params[:passenger_id].nil? && params[:driver_id]
        redirect_to driver_path(params[:driver_id])
        return
      else
        redirect_to root_path
        return
      end
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
