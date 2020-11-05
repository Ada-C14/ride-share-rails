class PassengersController < ApplicationController
  def index
    if params[:trip_id].nil?
      @passengers = Passenger.all
    else
      @trip = Trip.find_by(id: params[:id]).passenger_id
      @passengers = @trip.passenger_id
    end
  end

  def show
    passenger_id = params[:id].to_i
    @passenger = Passenger.find_by(id: passenger_id)
    @trips = Trip.where(passenger_id: @passenger.id)
    # @trip = Trip.find_by(id: params[:id]).passenger
    @driver = Driver.find_by(id: params[:id])

    if @passenger.nil?
      redirect_to passengers_path
      return
    end
  end

  def new
    if params[:trip_id].nil?
      @passenger = Passenger.new
    else
      trip = Trip.find_by(id: params[:trip_id])
      @passenger = trip.passenger_id.new
    end
  end

  def create
    @passenger = Passenger.new(passenger_params)

    if @passenger.save
      redirect_to passenger_path(@passenger.id)
      return
    else
      render :new
    end
  end

  def edit
    @passenger = Passenger.find_by(id: params[:id])

    if @passenger.nil?
      redirect_to passengers_path
      return
    end
  end

  def update
    @passenger = Passenger.find_by(id: params[:id])

    if @passenger.nil?
      redirect_to passengers_path
      return
    else @passenger.update(passenger_params)
      redirect_to passengers_path
    end
  end

  def destroy
    passenger = Passenger.find_by(id: params[:id])

    if passenger.nil?
      redirect_to passengers_path
      return
    else
      passenger.destroy
      redirect_to passengers_path
      return
    end
  end

  private

  def passenger_params
    return params.require(:passenger).permit(:id, :name, :phone_num, :trip_id)
  end

end

