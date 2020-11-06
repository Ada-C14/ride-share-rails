class PassengersController < ApplicationController
  def index
    @passengers = Passenger.all
  end

  def new
    @passenger = Passenger.new
  end

  def show
    passenger_id = params[:id]
    @passenger = Passenger.find_by(id: passenger_id)
    if @passenger.nil?
      redirect_to passengers_path
      return
    end
  end

  def create
    @passenger = Passenger.new(passenger_params)
    if @passenger.save # save returns true if the database insert succeeds
      redirect_to passenger_path(@passenger.id)
      return
    else
      render :new
      return
    end
  end

  def edit
    passenger_id = params[:id]
    @passenger = Passenger.find_by(id: passenger_id)

    if @passenger.nil?
      redirect_to passenger_path
      return
    end
  end

  def update
    passenger_id = params[:id]
    @passenger = Passenger.find_by(id: passenger_id)

    if @passenger.nil?
      redirect_to passenger_path
      return
    elsif @passenger.update(passenger_params)
      redirect_to passengers_path
      return
    else
      render :edit
      return
    end
  end

  def destroy
    passenger_id = params[:id]
    @passenger = Passenger.find_by(id: passenger_id)
    @passenger.destroy
    redirect_to passengers_path
  end


  private

  def passenger_params
    return params.require(:passenger).permit(:name, :phone_num)
  end

end
