class PassengersController < ApplicationController
  PASSENGERS = [
    {
      id: 1,
      name: "Nina Hintz Sr.",
      phone_num: "560.815.3059",
    },

    {
      id: 2,
      name: "Emory Rosenbaum",
      phone_num: "(392) 217-0777",

    },
  ]

  def index
    @passengers = PASSENGERS
  end

  def show
    passengers_id = params[:id].to_i
    @passengers = PASSENGERS[passengers_id]
    if @passengers.nil?
      head :not_found
      return
    end
  end

end
