class PassengersController < ApplicationController
  def index
    @passengers = Passenger.all.order(:name)
  end

  def show
    passenger_id = params[:id].to_i
    @passenger = Passenger.find_by(id: passenger_id)

    if @passenger.nil?
      return
    end
  end

  def new
    @passenger = Passenger.new
  end

  def edit
    passenger_id = params[:id].to_i
    @passenger = Passenger.find_by_id(passenger_id)

    if @passenger.nil?
      head :not_found
      return
    end
  end

  def create
    @passenger = Passenger.new(
        name: params[:passenger][:name],
        phone_num: params[:passenger][:phone_num]
    )

    if @passenger.save
      redirect_to passenger_path(@passenger.id)
    else
      render :new, :bad_request
    end
  end

  def update
    passenger_id = params[:id].to_i
    if passenger_id >= 0
      @passenger = Passenger.find_by_id(passenger_id)
    end

    if @passenger.nil?
      head :not_found
      return
    elsif @passenger.update(
        name: params[:passenger][:name],
        phone_num: params[:passenger][:phone_num])
      redirect_to passenger_path
      return
    else
      render :edit
      return
    end
  end

  def destroy
    passenger_id = params[:id].to_i
    @passenger = Passenger.find_by_id(passenger_id)

    if @passenger.nil?
      head :not_found
      return

    else
      @passenger.destroy
      redirect_to passenger_path
    end
  end
end
