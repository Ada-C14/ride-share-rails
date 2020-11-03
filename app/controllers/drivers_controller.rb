class DriversController < ApplicationController
  def index
    @drivers = Driver.all
  end

  def show
    driver_id = params[:id].to_i
    @driver = Driver.find_by(id: driver_id)

    if @driver.nil?
      redirect_to root_path
    end
  end

  def new
    @driver = Driver.new
  end

  def create
    @driver = Driver.new

    if @driver.save
      redirect_to driver_path(@driver.id)
    else
      render :new
    end
  end

  def edit
    @driver = Driver.find_by id: params[:id]
    if @driver.nil?
      redirect_to root_path
    end
  end

  def update
    @driver = Driver.find_by id: params[:id]
    if @driver.nil?
      redirect_to root_path
      return
    elsif @driver.update(driver_params)
      redirect_to driver_path(@driver.id)
      return
    else
      render :edit
      return
    end
  end

  def destroy
    @driver = Driver.find_by(id: params[:id])
    if @driver
      @driver.destroy
      redirect_to root_path
    else
      head :not_found
      return
    end
  end
end

private

def driver_params
  return params.require(:driver).permit(:name, :vin, :available)
end