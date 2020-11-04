class HomePagesController < ApplicationController
  def index
    @trips = Trip.all
  end
end
