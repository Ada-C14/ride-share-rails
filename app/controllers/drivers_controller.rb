class DriversController < ApplicationController

  def index
    @drivers = Driver.all
  end

  def show
    driver_id = params[:id]

    begin
      @driver = Driver.find(driver_id)
    rescue ActiveRecord::RecordNotFound
      @driver = nil
    end

    if @driver.nil?
      head :not_found
      return
    end
  end

  def new
    @driver = Driver.new
  end

  def create
    #instantiate a new driver
    @driver = Driver.new(
        name: params[:driver][:name],
        vin: params[:driver][:vin],
        available: params[:driver][:available])

    if @driver.save # save returns true if the database insert succeeds
      redirect_to driver_path @driver.id
      return
    else # if save is failed
      render :new
      return
    end
  end


  def edit
    @driver = Driver.find_by(id: params[:id])
    driver_id = params[:id]

    begin
      @driver = Driver.find(driver_id)
    rescue ActiveRecord::RecordNotFound
      @driver = nil
    end

    if @driver.nil?
      head :not_found
      return
    end
  end

  def update
    @driver = Driver.find_by(id: params[:id])
    if @driver.nil?
      head :not_found
      return
    elsif @driver.update(
        name: params[:driver][:name],
        vin: params[:driver][:vin],
        available: params[:driver][:available]
    )
      redirect_to driver_path # go to the driver details page
      return
    else # save failed
      render :edit # show the new driver form view again
      return
    end
  end

  def destroy
    driver_id = params[:id]
    @driver = Driver.find_by(id: driver_id)

    if @driver
      @driver.destroy
      redirect_to drivers_path #not sure where to redirect if driver was deleted
      return
    else
      head :not_found
      return
    end
  end

end