class PassengersController < ApplicationController
  def index
    @passengers = Passenger.all
  end

  def new
    @passenger = Passenger.new
  end

  def create
    @passenger = Passenger.new(passenger_params)

    if @passenger.save #is true
      redirect_to passenger_path(@passenger.id)
      return
    else #save failed
      render :new, :bad_request
      return
    end
  end

  def show
    id = params[:id]
    @passenger = Passenger.find_by(id: id)

    if @passenger.nil?
      #redirect_to root_path #???
    end
  end

  def edit
    id = params[:id]
    @passenger = Passenger.find_by(id: id)

    if @passenger.nil?
      redirect_to passengers_path #???CHANGE THIS LATER?
      return
    end
  end

  def update
    @passenger = Passenger.find_by(id: params[:id])

    if @passenger.nil?
      redirect_to passengers_path
      return
    elsif @passenger.update(passenger_params) #if this is true
      redirect_to passengers_path
      return
    else #save failed
      render :edit
      return
    end
  end

  def destroy
    id = params[:id]
    @passenger = Passenger.find_by(id: id)

    if @passenger.nil?
      head :not_found
      return
    end

    @passenger.destroy
    redirect_to passengers_path
    return
  end

  def passenger_params
    return params.require(:passenger).permit(:name, :phone_num)
  end


end
