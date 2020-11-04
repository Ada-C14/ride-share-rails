class PassengersController < ApplicationController

  # has_many :trips
  
  def index
    @passengers = Passenger.all
  end

  def show
    passenger_id = params[:id].to_i
    @passenger = Passenger.find_by(id: passenger_id)

    if @passenger.nil?
      head :not_found
      return
    end
  end

  def new
    @passenger = Passenger.new
  end

  def create
    @passenger = Passenger.new(passenger_params)

    if @passenger.save
      redirect_to passenger_path(@passenger)
    else
      redirect_to new_passenger_path
    end
  end

  def find_by_id
    passenger_id = params[:id].to_i
    passenger = Passenger.find_by(id: passenger_id)
  end

  def edit
    @passenger = find_by_id

    if @passenger.nil?
      redirect_to passengers_path
      return
    end
  end

  def update
    @passenger = find_by_id

    if @passenger.nil?
      head :not_found
      return
    elsif @passenger.update(passenger_params)
      redirect_to passenger_path(@passenger)
      return
    else
      render :bad_request
      return
    end
  end

  def destroy
    @passenger = find_by_id

    if @passenger.nil?
      head :not_found
      return
    else
      @passenger.destroy
      redirect_to passengers_path
    end
  end

  private

  def passenger_params
    return params.require(:passenger).permit(:name, :phone_num)
  end
end
