class DriversController < ApplicationController

  def index
    @drivers = Driver.all
  end

  def show
    driver_id = params[:id]

    begin
      @driver = Driver.find(driver_id)
    rescue ActiveRecord::RecordNotFound
      @driver = nil
    end

    if @driver.nil?
      head :not_found
      return
    end
  end
end