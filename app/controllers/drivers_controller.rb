class DriversController < ApplicationController

  def index
    #give us all drivers
    @drivers =Driver.all
  end

  def new
    @driver=Driver.new
  end

  def create #can we use the driver params here?
    #@driver=Drive.new(
    #   name: params[:driver][:name]
    #   vin: params[:driver]:[vin])
    @driver=Driver.new(driver_params)
    if @driver.save
      head :success
      return
    else
      render :new
      return
    end
  end

  def show
    @driver= Driver.find_by(driver.id) #(id: @driver.id)
    if @driver.nil?
      redirect_to :driver
    end
  end

  def update

  end

  def edit
    @driver=Task.find_by(id:params[:id])

    if @driver.nil?
  end


  def destroy

  end

  private

  # params = {id: 1, driver: {name: "hello world", author: becca}}
  #
  # params[:id]
  # params[:driver][:name]

  def driver_params
    return params.require(:driver).permit(:name, :vin, :available)
  end

end

