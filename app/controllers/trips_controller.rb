class TripsController < ApplicationController

  def index
    @trips = Trip.all
  end

  def create

  end

  def new
    @trip = Trip.new
  end

  def edit

  end

  def update

  end

  def destroy

  end

  private

  def action_success_check(action, redirect_path)
    if action
      redirect_to redirect_path
    else
      render :new, bad_request
    end
  end

  def passenger_params
    return params.require(:passenger).permit(:name, :phone_num)
  end

  def find_passenger
    return Passenger.find_by(id: params[:id].to_i)
  end
end
