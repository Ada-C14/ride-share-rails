class HomepagesController < ApplicationController
  def index
    @passengers = Passenger.all
    @trips = Trip.all
    @drivers = Driver.all

  end
end
