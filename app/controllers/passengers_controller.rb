class PassengersController < ApplicationController
  def index
    @passengers = Passenger.all.order(:id).page(params[:page])
  end

  def show
    id = params[:id].to_i
    @passenger = Passenger.find_by(id: id)

    if @passenger.nil?
      head :not_found
      return
    end
  end

  def update
    id = params[:id].to_i
    @passenger = Passenger.find_by(id: id)

    if @passenger.nil?
      head :not_found
      return
    elsif @passenger.update(passenger_params)
      redirect_to passengers_path
      return
    else
      render :edit
      return
    end
  end

  def edit
    id = params[:id].to_i
    @passenger = Passenger.find_by(id: id)

    if @passenger.nil?
      head :not_found
      return
    end
  end

  def destroy
    id = params[:id].to_i
    @passenger = Passenger.find_by(id: id)

    if @passenger
      @passenger.destroy
      redirect_to passengers_path
    else
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
      redirect_to passenger_path(@passenger.id)
    else
      render :new
      return
    end
  end

  private

  def passenger_params
      return params.require(:passenger).permit(:name, :phone_num)
  end


  end
