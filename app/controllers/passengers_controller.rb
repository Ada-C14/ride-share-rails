class PassengersController < ApplicationController

  def index
    @passengers = Passenger.all.order(:id)
  end

  def show
    passenger_id = params[:id].to_i
    @passenger = Task.find_by(id: passenger_id)

    if @passenger.nil?
      redirect_to passengers_path
      return
    end
  end

  def new

  end

  def create

  end

  def edit

  end

  def update

  end

  def destroy

  end

end
