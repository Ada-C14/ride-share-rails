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
    passenger = Passenger.new(
        name: params[:passenger][:name],
        phone_num: params[:passenger][:phone_num]
        )

    if passenger.save
      redirect_to passenger_path(passenger) #send to show
    else
      render :new
    end
  end

  def update
    @passenger = Passenger.find_by(id: params[:id])
    if @passenger.nil?
      head :not_found
      return
    elsif @passenger.update(
        name: params[:passenger][:name],
        phone_num: params[:passenger][:phone_num]
    )
      redirect_to passenger_path # go to the index so we can see the book in the list
      return
    else # save failed :(
    render :edit
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

end
