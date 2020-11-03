class TripsController < ApplicationController
  belongs_to :driver
  belongs_to :passenger
  def index
    @trips = Trip.all
  end
end
