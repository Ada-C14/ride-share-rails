class PassengersController < ApplicationController

  def index
    @passengers = Passenger.all
  end

  def show
    @passengers = Passenger.find_by(id: params[:id])
    if @passengers.nil?
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
    end
  end
  
  def edit
    @passenger = Passenger.find_by(id: params[:id])
    if @passengers.nil?
      render :edit 
      return
    end
  end

  def update
    @passenger = Passenger.find_by(id: params[:id])
    if @passenger.nil?
      head :not_found
      return
    elsif @passenger.update(passenger_params)
      flash[:success] = "passenger updated successfully"
      redirect_to passenger_path # go to the show so we can see the passenger
      return
    else # save failed :(
    flash.now[:error] = "Something happened. passenger not updated."
    render :edit, status: :bad_request # show the new passenger form view again
    return
    end
  end

  def destroy
    @passenger = Passenger.find_by(id: params[:id])
    if @passenger.nil?
      redirect_to root_path
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
