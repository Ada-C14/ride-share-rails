class DriversController < ApplicationController

  def index
    @drivers = Driver.all
  end

  def show
    driver_id = params[:id].to_i
    @drivers = Driver.find_by(id: driver_id)
    if @drivers.nil?
      head :not_found
      return
    end
  end



end
