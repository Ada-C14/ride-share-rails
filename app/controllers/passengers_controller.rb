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

    def new
      @passenger = Passenger.new
    end


    def create
      @passenger = Passenger.new(passenger_params) #new passenger
      if @passenger.save
        redirect_to root_path # go to the index page so we can see the passenger in the list
        return
      else
      render :new, status: :bad_request # show the new book form view again
      return
      end
    end

end
