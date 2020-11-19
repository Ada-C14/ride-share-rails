class DriversController < ApplicationController
    def index
        @drivers = Driver.all
    end

    def show # details of an instance of an object
        driver_id = params[:id]
        @driver = Driver.find_by(id: driver_id)
    
        if @driver.nil?
          redirect_to drivers_path
          return
        end
    end
    
      def update
        @driver = Driver.find_by(id: params[:id])
        if @driver.nil?
            redirect_to drivers_path
            return
        elsif @driver.update(driver_params)# using strong params
            redirect_to drivers_path
          return
        else # save failed
          render :edit
          return
        end
      end
    
      def edit
        @driver = Driver.find_by(id: params[:id])
        if @driver.nil?
            redirect_to drivers_path
            return
        end
      end
    
      def new 
        @driver = Driver.new 
      end
    
      def create
        # instantiate a new driver
        @driver = Driver.new(driver_params)# using strong params
       
        if @driver.save # save returns true if the database insert succeeds
          redirect_to drivers_path(@driver.id) # go to the index so we can see the drivers in the list
          return
        else # save failed 
          render :new # show the new driver form view again
          return
        end
      end
    
      def destroy
        driver_id = params[:id] #params is a method returning a hash that uses to access hashes. 
        @driver  = Driver.find_by(id: driver_id) # find a driver given an id
    
        if @driver.nil?
          redirect_to drivers_path
          return
        else 
          @driver.destroy
          redirect_to drivers_path
        end
      end
    
      private
    
      def driver_params
        return params.require(:driver).permit(:name, :vin, :available)
      end
    
    
end
