class DriversController < ApplicationController
  def index
    @drivers = Driver.all
  end

  def new
    @driver = Driver.new
  end

  def show
    driver_id = params[:id]
    @driver = Driver.find_by(id: driver_id)
    if @driver.nil?
      redirect_to drivers_path
      return
    end
  end

  def create
    @driver = Driver.new(driver_params.merge({ available: true }))
    if @driver.save # save returns true if the database insert succeeds
      redirect_to driver_path(@driver.id)
      return
    else
      render :new
      return
    end
  end

  def edit
    driver_id = params[:id]
    @driver = Driver.find_by(id: driver_id)

    if @driver.nil?
      redirect_to driver_path
      return
    end
  end

  def update
    driver_id = params[:id]
    @driver = Driver.find_by(id: driver_id)

    if @driver.nil?
      redirect_to root_path
      return
    elsif @driver.update(driver_params)
      redirect_to drivers_path
      return
    else
      render :edit
      return
    end
  end

  def destroy
    driver_id = params[:id]
    @driver = Driver.find_by(id: driver_id)
    @driver.destroy
    redirect_to root_path
  end

  def availability
    driver_id = params[:id]
    @driver = Driver.find_by(id: driver_id)
    if @driver.available.true
      @driver.available = false
    elsif @driver.available.false
      @driver.available = true
    end
    @driver.save
    redirect_to root_path
  end


  private

  def driver_params
    return params.require(:driver).permit(:name, :vin, :available)
  end

end


