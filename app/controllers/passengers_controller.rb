class PassengersController < ApplicationController

  def index
    @passengers = Passenger.all.order(:id)
  end

  def show
    passenger_id = params[:id].to_i
    @passengers = Passenger.find_by(id: passenger_id)

    if @passengers.nil?
      head :not_found
      return
    end
  end

  def new
    @passengers = Passenger.new
  end

  def create
    @passengers = Passenger.new(passengers_params)
    if @passengers.save # save returns true if the database insert succeeds
      redirect_to passengers_path(@passengers.id) # go to the index so we can see the task in the list
      return
    else # save failed :(
    render :new # show the new task form view again
    return
    end
  end

  def edit
    @passengers = Passenger.find_by(id: params[:id])
    if @passengers.nil?
      redirect_to passengers_path
      return
    end
  end

  def update
    @passengers = Passenger.find_by(id:params[:id])

    if @passengers.nil?
      head :not_found
      return
    elsif @passengers.update(passengers_params)
      redirect_to passenger_path(@passengers.id)
      return
    else
      render :edit
    end
  end

  def destroy
    passenger_id = params[:id]
    @passengers = Passenger.find_by(id:passenger_id)

    if @passengers.nil?
      head :not_found
      return
    else
      @passengers.destroy
      redirect_to passengers_path
    end
  end

end


private

def passengers_params
  return params.require(:passenger).permit(:name, :phone_num)
end