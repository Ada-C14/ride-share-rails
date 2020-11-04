class DriversController < ApplicationController

  def index
    #give us all drivers
    @drivers =Driver.all
  end

  def show

  end

  def new
    @driver=Driver.new
  end

  def create
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

  end


  def destroy

  end

  private
  def driver_params
    return params.require(:driver).permit(:name, :vin, :available)
  end

end

