class HomepageController < ApplicationController
  def index
    @trip = Trip.all
  end
end
