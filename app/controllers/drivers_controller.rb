class DriversController < ApplicationController

  def index
    @drivers = Driver.all
  end

  def show
    @driver = Driver.find_by(id: params[:id])

    if @driver.nil?
      redirect_to driver_path
      return
    end
  end

end
