class TripsController < ApplicationController

  private

  def trip_params
    return params.require(:trip).permit(:id, :driver_id, :passenger_id, :date, :rating, :cost)
  end
end
