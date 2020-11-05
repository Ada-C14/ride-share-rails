class PassengersController < ApplicationController


  before_action :find_by, except: [:index, :new, :create]

  def index
    @passengers = Passenger.all
  end

  def show

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
      return
    else
      render :new
      return
    end

  end

  def edit

    if @passenger.nil?
      redirect_to passengers_path
      return
    end
  end

  def update

    if @passenger.nil?
      redirect_to passengers_path
      return
    elsif @passenger.update(passenger_params)
      redirect_to passenger_path(@passenger.id)
      return
    else
      render :edit
      return
    end
  end

  def destroy

    if @passenger.nil?
        redirect_to passengers_path
        head :not_found
    end

    @passenger.destroy

    redirect_to passengers_path
    return
  end

  private

  def find_by
    passenger_id = params[:id].to_i
    passenger = Passenger.find_by(id: passenger_id)
  end

  def passenger_params
    return params.require(:passenger).permit(:name, :phone_num)
  end

end
