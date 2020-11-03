# frozen_string_literal: true

class DriversController < ApplicationController
  def index
    @drivers =
  end

  def show
    driver_id = params[:id]
    @driver = Task.find_by(id: driver_id)
    if @driver.nil?
      redirect_to drivers_path
      return
      head :not_found
      return
    end
  end
end
