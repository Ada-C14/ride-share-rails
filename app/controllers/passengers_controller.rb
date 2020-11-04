class PassengersController < ApplicationController
  def index
    @passengers = Passenger.all
  end

  def show
    id = params[:id].to_i
    @passenger = Task.find_by(id: id)
    if @passenger.nil?
      head :not_found
      return
    end
  end

  def update
    @passenger = Passenger.find_by(id: params[:id])

    if @passenger.nil?
      redirect_to passengers_path
      return
    elsif @passenger.update(
        name: params[:passenger][:name],
        phone_num: params[:passenger][:phone_num]
    )
      redirect_to passengers_path
      return
    else
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

  def destroy
    task_id = params[:id]
    @passenger = Task.find_by(id: task_id)

    if @passenger
      @passenger.destroy
      redirect_to passengers_path
    else
      head :not_found
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
      redirect_to passenger_path(passenger.id)
    else
      render :new, :bad_request
    end
  end

  private

  def passenger_params
      return params.require(:passenger).permit(:name, :phone_num)
  end


  end
