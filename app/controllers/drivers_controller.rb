class DriversController < ApplicationController

  def index
    @drivers = Driver.order(:id)
  end

  def show
    @driver = Driver.find_by(id: params[:id])
    if @driver.nil?
      render :notfound, status: :not_found
      return
    end
  end

  def new
    @driver = Driver.new
  end

  def create
    @driver = Driver.new(driver_params)
    @driver.available = true if @driver.available.nil?
    if @driver.save
      redirect_to drivers_path
      return
    else #save failed
      render :new, status: :bad_request
      return
    end
  end

  def edit
    @driver = Driver.find_by(id: params[:id])
    if @driver.nil?
      render :notfound, status: :not_found
      return
    end
  end

  def update
    @driver = Driver.find_by(id: params[:id])

    # is this check necessary?
    if @driver.nil?
      render :notfound, status: :not_found
      return
    elsif @driver.update(driver_params)
      redirect_to drivers_path
      return
    else # update failed
      render :edit, status: :bad_request
      return
    end
  end

  def destroy
    @driver = Driver.find_by(id: params[:id])
    if @driver
      @driver.delete
      redirect_to drivers_path
      return
    else
      render :notfound, status: :not_found
      return
    end
  end

  private

  def driver_params
    return params.require(:driver).permit(:name, :vin)
  end
end
