class DriversController < ApplicationController
  drivers = [
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
    @drivers = drivers
  end
end
