class TripsController < ApplicationController
  def show
    @trip = Trip.find_by(id: params[:id])

    if @trip.nil?
      redirect_to root_path
      return
    end
  end
end
