class PassengersController < ApplicationController
  def index
    @passengers = Passenger.order(:id)
  end

  def show
    @passenger = Passenger.find_by(id: params[:id])

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
      redirect_to passengers_path
      return
    else # save failed
      render :new, status: :bad_request
      return
    end

  end

  def edit
    @passenger = Passenger.find_by(id: params[:id])

    if @passenger.nil?
      head :not_found
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
    else # save failed
      render  :edit, status: :bad_request
      return
    end

  end

  def destroy
    @passenger = Passenger.find_by(id: params[:id])

    if @passenger.nil?
      head :not_found
      return
    else
      @passenger.destroy
      @passenger.trips.each {|trip| trip.destroy}
      redirect_to passengers_path
      return
    end

  end

  private

  def passenger_params
    return params.require(:passenger).permit(:name, :phone_num)
  end




end
