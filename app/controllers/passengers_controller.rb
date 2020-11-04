class PassengersController < ApplicationController
  # Helper Methods
  def not_found_error_notice
    flash[:notice] = "Uh oh! That passenger does not exist..."
    redirect_to passengers_path
  end

  def not_saved_error_notice
    flash[:notice] = "Uh oh! That did not save correctly."
    render :new
  end

  #########################################################

  def index
    @passengers = Passenger.all.order(:name)
  end

  def show
    passenger_id = params[:id].to_i
    @passenger = Passenger.find_by(id: passenger_id)

    if @passenger.nil?
      not_found_error_notice
      return
    end
  end

  def new
    @passenger = Passenger.new
  end

  def edit
    passenger_id = params[:id].to_i
    @passenger = Passenger.find_by(id: passenger_id)

    if @passenger.nil?
      not_found_error_notice
      return
    end
  end

  def create
    @passenger = Passenger.new(passenger_params)

    if @passenger.save
      redirect_to passenger_path(@passenger.id)
      return
    else
      not_saved_error_notice
      return
    end
  end

  def update
    @passenger = Passenger.find_by(id: params[:id])

    if @passenger.nil?
      not_found_error_notice
      return
    elsif @passenger.update(passenger_params)
      redirect_to passenger_path
      return
    else
      not_saved_error_notice
      return
    end
  end

  def destroy
    @passenger = Passenger.find_by(id: params[:id])

    if @passenger.nil?
      not_found_error_notice
      return
    else
      @passenger.destroy
      redirect_to passengers_path
      return
    end
  end

  private

  def passenger_params
    return params.require(:passenger).permit(:name, :phone_num)
  end
end
