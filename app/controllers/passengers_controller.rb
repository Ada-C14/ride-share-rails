class PassengersController < ApplicationController

  def index
    @passengers = Passenger.all
  end

  def show
    @passenger = Passenger.find_by(id: params[:id])
    if @passenger.nil?
      head :not_found
      return
    end
  end

  def new
    @passenger = Passenger.new
    if params[:passenger_id].nil?
      @trip = Trip.new
    else
      passenger = passenger.find_by(id: params[:id])
      passenger.trips.new
    end
  end

  def create
    @passenger = Passenger.new(passenger_params)
    if @passenger.save
      redirect_to passenger_path(@passenger.id)
      return
    else
      render :new
      return
    end
  end

  def edit
    @passenger = Passenger.find_by(id: params[:id])
    if @passenger.nil?
      head :not_found
      return
    end
  end

  def update
    @passenger = Passenger.find_by(id: params[:id])
    if @passenger.nil?
      head :not_found
      return
    elsif @passenger.update(passenger_params)
      redirect_to passenger_path
      return
      render :edit
      return
    end
  end

  def destroy
    @passenger = Passenger.find_by(id: params[:id])
    if @passenger.nil?
      head :not_found
      return
    else
      @passenger.destroy
      redirect_to passengers_path
      return
    end
  end


  private
  def passenger_params
    return params.require(:passenger).permit(:id, :name, :phone_num)
  end
end
