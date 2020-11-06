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
  end

  def new
    @driver = Driver.new
  end

  def create
    @driver = Driver.new(driver_params)
    @driver.available = true

    if @driver.save
      redirect_to driver_path(@driver.id)
      return
    else
      render :new, status: :bad_request
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
      head :not_found
      return
    elsif @driver.update(driver_params)
      redirect_to driver_path(@driver.id)
      return
    else # save failed :(
      render :edit, status: :bad_request
      return
    end
  end

  def destroy
    @driver = Driver.find_by(id: params[:id])

    if @driver.nil?
      head :not_found
      return
    elsif @driver.trips.empty?
      @driver.destroy
      redirect_to drivers_path
      return
    else
      redirect_to driver_path(@driver.id)
      return
    end
  end

  private
  def driver_params
    return params.require(:driver).permit(:name, :vin, :available)
  end
end
