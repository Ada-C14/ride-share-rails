class DriversController < ApplicationController

  has_many :trips

  def index
    @drivers = Driver.all
  end

  def show
    driver_id = params[:id].to_i
    @driver = Driver.find_by(id: driver_id)

    if @driver.nil?
      head :not_found
      return
    end
  end

  def new
    @driver = Driver.new
  end

  def create
    @driver = Driver.new(driver_params)

    if @driver.save
      redirect_to driver_path(@driver)
    else
      redirect_to new_driver_path
    end
  end

  def find_by_id
    driver_id = params[:id].to_i
    driver = Driver.find_by(id: driver_id)
  end

  def edit
    @driver = find_by_id

    if @driver.nil?
      redirect_to drivers_path
      return
    end
  end

  def update
    @driver = find_by_id

    if @driver.nil?
      head :not_found
      return
    elsif @driver.update(driver_params)
      redirect_to driver_path(@driver)
      return
    else
      render :bad_request
      return
    end
  end

  def destroy
    @driver = find_by_id

    if @driver.nil?
      head :not_found
      return
    else
      @driver.destroy
      redirect_to drivers_path
    end
  end

  private

  def driver_params
    return params.require(:driver).permit(:name, :vin, :available).with_defaults(available: true)
  end
end