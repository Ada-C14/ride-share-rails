class DriversController < ApplicationController

  before_action :find_driver, except: [:index, :new, :create]

  def index
    @drivers = Driver.all.order(:name)
  end

  def show
    #find_driver
    if @driver.nil?
      redirect_to drivers_path
      return
    end
  end

  def new
    @driver = Driver.new
  end

  def create
    @driver = Driver.new(driver_params)

    # save returns true if the database insert succeeds
    if @driver.save
      # go to the index so we can see the driver in the list, send them back to '/drivers' path
      redirect_to driver_path(@driver.id)
      return
    else # save failed
    render :new, status: :bad_request         # show the new driver form view again
    return
    end
  end

  def edit
    #find_driver
    if @driver.nil?
      redirect_to edit_driver_path
      # we can redirect to drivers_path index
      # or back to edit with friendly error message
      return
    end
  end

  def update
    #find_driver
    if @driver.nil?
      redirect_to drivers_path
      return
    elsif @driver.update(driver_params)
      redirect_to driver_path(@driver.id)
      #stays on specific driver page to show update. Otherwise will have to find driver in list to see changes
      return
    else                # save failed
    render :edit      # show the new task form view again
    return
    end
  end

  def destroy
    #find_driver
    if @driver
      #also iterate through trips and destroy those
      @driver.destroy
      redirect_to drivers_path
    else
      head :not_found
    end
    return
  end

  def toggle_status
    if @driver.available == true
      @driver.update(available: false)
      redirect_to driver_path(@driver)
      return
    else
      @driver.update(available: true)
      redirect_to driver_path(@driver)
      return
    end

  end

  private

  def find_driver
    @driver = Driver.find_by(id: params[:id])
  end

  def driver_params
    params.require(:driver).permit(:name, :vin, :available)
  end

end
