class PassengersController < ApplicationController
  def index
    @passengers = Passenger.all
  end

  def show
    passenger_id = params[:id].to_i
    @passenger = Passenger.find_by(id: passenger_id)

    if @passenger.nil?
      redirect_to passengers_path
      return
    end
  end

  def new
    @passenger = Passenger.new
  end

  def create
    @passenger = Passenger.new(passenger_params)

    if @passenger.save
      redirect_to passenger_path(@passenger.id)
    else
      render :new, status: :bad_request
      return
    end
  end

  def edit
    @passenger = Passenger.find_by(id: params[:id])

    if @passenger.nil?
      redirect_to passengers_path
      return
    end
  end

  def update
    @passenger = Passenger.find_by(id: params[:id])

    if @passenger.nil?
      head :not_found
      return
    elsif @passenger.update(passenger_params)
      redirect_to passengers_path
      return
    else
      render :edit, status: :bad_request
      return
    end
  end

  def destroy
    @passenger = Passenger.find_by(id: params[:id])

    if @passenger.nil?
      head :not_found
      return
    end

    @passenger.destroy

    redirect_to passengers_path
    return
  end

  private

  def passenger_params
    return params.require(:passenger).permit(:passenger_id, :name, :phone_num)
  end

end
