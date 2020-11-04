class PassengersController < ApplicationController

  def index
    @passengers = Passenger.all
  end

  def show
    @passenger_id = params[:id].to_i
    @passenger = Passenger.find(@passenger_id)
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

  private

  def passender_params
    return params.require(:passenger).permit(:name, :phone_num)

  end

end
