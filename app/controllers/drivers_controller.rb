class DriversController < ApplicationController
  def index
    @drivers = Driver.all.order(:id)
  end
end