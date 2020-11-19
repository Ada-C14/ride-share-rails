class PassengersController < ApplicationController
    def index
        @passengers = Passenger.all
    end

    def show # details of an instance of an object
        passenger_id = params[:id]
        @passenger = Passenger.find_by(id: passenger_id)
    
        if @passenger.nil?
          redirect_to passengers_path
          return
        end
    end
    
      def update
        @passenger = Passenger.find_by(id: params[:id])
        if @passenger.nil?
            redirect_to passengers_path
            return
        elsif @passenger.update(passenger_params)# using strong params
            redirect_to passengers_path
          return
        else # save failed
          render :edit
          return
        end
      end
    
      def edit
        @passenger = Passenger.find_by(id: params[:id])
        if @passenger.nil?
            redirect_to passengers_path
            return
        end
      end
    
      def new 
        @passenger = Passenger.new 
      end
    
      def create
        # instantiate a new passenger
        @passenger = Passenger.new(passenger_params)# using strong params
       
        if @passenger.save # save returns true if the database insert succeeds
          redirect_to passengers_path(@passenger.id) # go to the index so we can see the passengers in the list
          return
        else # save failed 
          render :new # show the new passenger form view again
          return
        end
      end
    
      def destroy
        passenger_id = params[:id] #params is a method returning a hash that uses to access hashes. 
        @passenger  = Passenger.find_by(id: passenger_id) # find a passenger given an id
    
        if @passenger.nil?
          redirect_to passengers_path
          return
        else 
          @passenger.destroy
          redirect_to passengers_path
        end
      end
    
      private
    
      def passenger_params
        return params.require(:passenger).permit(:name, :phone_num)
      end
    
    
end
