class PassengersController < ApplicationController
  has_many :trips
  def index
    @passengers = Passenger.all
  end
end
