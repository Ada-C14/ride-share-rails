class PassengersController < ApplicationController
  def index
    @passenger = Passenger.all
  end

  def show
    @passenger = Passenger.find_by(id: params[:id])

    if @passenger.nil?
      head :not_found
      return
    end

    @trips = @passenger.trips

    @total_trips = 0
    @total_cost = 0
    if @trips != nil || @trips != []
      @trips.each do |trip|
        @total_cost += trip.cost
      end
      @total_trips = @trips.length
    end
    return
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
    render :new, status: :bad_request
    return
    end
  end

  def edit
    @passenger = Passenger.find_by(id: params[:id])

    if @passenger.nil?
      head :not_found
      return "Passenger not found"
    end
  end

  def update
    @passenger = Passenger.find_by(id: params[:id])
    if @passenger.nil?
      head :not_found
      return "Passenger not found"
    elsif @passenger.update(passenger_params)
      redirect_to passenger_path(@passenger)
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
    return params.require(:passenger).permit(:name, :phone_num)
  end

end
