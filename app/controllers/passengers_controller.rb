class PassengersController < ApplicationController


    def index
      @passengers = Passenger.all
    end

    def show
      passenger_id = params[:id]

      begin
        @passenger = Passenger.find(passenger_id)
      rescue ActiveRecord::RecordNotFound
        @passenger = nil
      end

      if @passenger.nil?
        head :not_found
        return
      end
    end

end
