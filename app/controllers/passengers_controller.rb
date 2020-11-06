class PassengersController < ApplicationController

  def index
    @passengers = Passenger.all
  end

  def show
    passenger_id = params[:id].to_i
    @passengers = Passenger.find_by(id: passenger_id)
    if @passengers.nil?
      head :not_found
      return
    end
  end

  def edit
    if @passengers.nil?
      render :edit 
      return
    end
  end


end
