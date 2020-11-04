class DriversController < ApplicationController
  DRIVERS = [
    {
      id: 1, 
      name: "Bernardo Prosacco", 
      vin: "WBWSS52P9NEYLVDE9",
      available: true
    },

    {
      id: 2, 
      name: "Emory Rosenbaum", 
      vin: "1B9WEX2R92R12900E",
      available: true
    }
  ]

  def index
    @drivers = DRIVERS
  end

  def show
    drivers_id = params[:id].to_i
    @drivers = DRIVERS[drivers_id]
    if @drivers.nil?
      head :not_found
      return
    end
  end



end
