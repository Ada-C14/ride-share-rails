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
    @passenger = Passenger.find_by(id: params[:id])
    if @passenger.nil?
      redirect_to root_path
      return
    end
  end

  def update
  end

  def destroy
    passenger = Passenger.find_by(id: params[:id])

    if passenger.nil?
      head :not_found
      return
    else
      passenger.destroy
      redirect_to passengers_path
    end
  end

  private

  def passenger_params
    return params.require(:passenger).permit(:name, :phone_num)

  end
end
