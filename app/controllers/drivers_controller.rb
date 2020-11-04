class DriversController < ApplicationController

  def index
    @drivers = Driver.all
  end

  def show
    @driver_id = params[:id].to_i
    @driver = Driver.find(@driver_id)
    if @driver.nil?
      redirect_to drivers_path
      return
    end
  end

  def new
  end

  def create
  end

  def edit
    @driver = Driver.find_by(id: params[:id])
    if @driver.nil?
      redirect_to root_path
      return
    end
  end

  def update
  end

  def destroy
    driver = Driver.find_by(id: params[:id])

    if driver.nil?
      head :not_found
      return
    else
      driver.destroy
      redirect_to drivers_path
    end
  end

  def set_available
  end

  private

  def driver_params
  end
end
