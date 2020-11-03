class DriversController < ApplicationController
  def index
    @drivers = Driver.all
  end

  # def show
  #   driver_id = params[:id].to_i
  #   @driver = Task.find_by(id: driver_id)
  #
  #   if @driver.nil?
  #     redirect_to drivers_path
  #     return
  #   end
  # end
end