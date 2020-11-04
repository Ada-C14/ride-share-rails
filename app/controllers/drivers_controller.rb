class DriversController < ApplicationController
  def index
    @drivers = Driver.all.order(:id)
  end

  def show
    @driver = Driver.find_by(id: params[:id])

    if @driver.nil?
      head :not_found
      return
    end
  end

  def new
    @driver = Driver.new
  end
end