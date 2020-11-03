class DriversController < ApplicationController

  def index
    @drivers = Driver.all
  end

  def show
    @driver = Driver.find_by(id: params[:id])

    if @driver.nil?
      render :notfound, status: :not_found
    end
  end

  def new
    @driver = Driver.new
  end

  def create
    @driver = Driver.new(driver_params)

    if @driver.save
      redirect_to driver_path(@driver)
    else # save failed?
      render :new
    end

  end

  def edit

  end

  def update

  end

  def destroy
    @driver = Driver.find_by(id: params[:id])
  end

  private

  def driver_params
    return params.require(:driver).permit(:name, :vin, :available)
  end
end
