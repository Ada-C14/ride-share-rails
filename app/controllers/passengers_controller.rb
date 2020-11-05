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
      @passenger = Passenger.new(name: params[:passenger][:name], phone_num: params[:passenger][:phone_num]) #new passenger
      if @passenger.save
        redirect_to passenger_path @passenger.id# go to the index page so we can see the passenger in the list
        return
      else
      render :new, status: :bad_request # show the new passenger form view again
      return
      end
    end

    def edit
      @passenger = Passenger.find_by(id: params[:id])
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

    def update
      @passenger = Passenger.find_by(id: params[:id])
      if @passenger.nil?
        head :not_found
        return
      elsif @passenger.update(
          name: params[:passenger][:name], phone_num: params[:passenger][:phone_num] )
        redirect_to passenger_path # go to the passenger details page
        return
      else # save failed
      render :edit # show the new passenger form view again
      return
      end
    end

    def destroy
      passenger_id = params[:id]
      @passenger = Passenger.find_by(id: passenger_id)

      if @passenger
        @passenger.destroy
        redirect_to passengers_path
        return
      else
        head :not_found
        return
      end
    end


end
