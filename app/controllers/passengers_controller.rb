class PassengersController < ApplicationController

  def index
    @passengers = Passenger.all
  end

  def show
    @passenger = find_passenger
    redirect_to passengers_path and return if @passenger.nil?
  end

  def create
    passenger = Passenger.new(passenger_params)
    action_success_check(passenger.save, passenger_path(passenger.id))
  end

  def new
    @passenger = Passenger.new
  end

  def edit
    @passenger = find_passenger

    redirect_to passengers_path and return if @passenger.nil?
  end

  def update
    passenger = find_passenger

    redirect_to passengers_path and return if passenger.nil?

    action_success_check(passenger.update(passenger_params), passenger_path)
  end

  def destroy
    passenger = find_passenger

    redirect_to passengers_path and return if passenger.nil?

    action_success_check(passenger.destroy, passengers_path)
  end

  private


  def passenger_params
    return params.require(:passenger).permit(:passenger_id, :phone_num, :name)
  end

  def find_passenger
    return Passenger.find_by(id: params[:id].to_i)
  end

end
