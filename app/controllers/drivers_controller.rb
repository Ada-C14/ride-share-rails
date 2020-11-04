class DriversController < ApplicationController
  def index
    @drivers = Driver.all
  end

  def show
    @driver = Driver.find_by(id: params[:id])

    if @driver.nil?
      redirect_to drivers_path and return
    end
  end

  def new
    @driver = Driver.new
  end

  def create
    @driver = Driver.new(driver_params)

    if @driver.save
      redirect_to driver_path(@driver) and return
    else
      render :new and return
    end
  end

  def edit
    @driver = Driver.find_by(id: params[:id])

    if @driver.nil?
      redirect_to drivers_path and return
    end
  end

  def update
    @driver = Driver.find_by(id: params[:id])

    if @driver.nil?
      redirect_to drivers_path and return
    elsif @driver.update(driver_params)
      redirect_to driver_path(@driver) and return
    else
      render :edit and return
    end
  end

  def destroy
    @driver = Driver.find_by(id: params[:id])

    if @driver
      @driver.destroy
      redirect_to drivers_path and return
    else
      redirect_to drivers_path and return
    end
  end

  private

  def driver_params
    return params.require(:driver).permit(:name, :vin, :available)
  end
end
