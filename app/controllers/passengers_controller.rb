class PassengersController < ApplicationController

  def index
    @passengers = Passenger.all
  end

  def show
    @passenger = Passenger.find_by(id: params[:id])

  if @passenger.nil?
    redirect_to passenger_path
    return
  end
end

end
