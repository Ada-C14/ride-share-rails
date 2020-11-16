class DriversController < ApplicationController
  def index
    @drivers = Driver.all
  end

  def show
    @driver = Driver.find_by(id: params[:id])

    if @driver.nil?
      redirect_to drivers_path
      return
    end

    @trips = Trip.where(driver_id: @driver.id)
    @passengers = Passenger.find_by(id: params[:id])

  end

  def new
    @driver = Driver.new
  end

  def create
    @driver = Driver.new(driver_params)
    # default: a new driver is available
    @driver[:available] = true
    result = @driver.save

    if result
      redirect_to driver_path(@driver.id)
      return
    else
      render :new
      return
    end
  end

  def edit
    @driver = Driver.find_by(id: params[:id])

    if @driver.nil?
      redirect_to drivers_path
      return
    end
  end

  def update
    @driver = Driver.find_by(id: params[:id])

    if @driver.nil?
      redirect_to drivers_path
      return
    end

    result = @driver.update(driver_params)

    if result
      redirect_to driver_path
      return
    else
      render :edit
      return
    end
  end

  def destroy
    driver = Driver.find_by(id: params[:id])

    if driver.nil?
      redirect_to drivers_path
      return
    elsif driver.destroy
      redirect_to drivers_path
      return
    end
  end

  private

  def driver_params
    return params.require(:driver).permit(:id, :name, :vin, :available, :created_at, :updated_at)
  end
end
