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
  end

  def update
  end

  def destroy
  end

  def set_available
  end

  private

  def driver_params
  end
end
