class DriversController < ApplicationController
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
      redirect_to driver_path(@driver.id)
    else
      render :new
    end
  end

  def edit
    @driver = Driver.find_by(id: params[:id])
    if @driver.nil?
      redirect_to drivers_path
      return
    end
  end

  def update
    @driver = Driver.find_by(id: params[:id])
    if @driver.nil?
      head :not_found
      return
    elsif @driver.update(driver_params)
      flash[:success] = "Driver updated successfully"
      redirect_to driver_path # go to the show so we can see the driver
      return
    else # save failed :(
      flash.now[:error] = "Something happened. Driver not updated."
      render :edit, status: :bad_request # show the new driver form view again
      return
    end
  end

  def destroy
    @driver = Driver.find_by(id: params[:id])
    if @driver.nil?
      redirect_to root_path
      return
    else
      @driver.destroy
      redirect_to drivers_path
    end
  end

  def unavailable
    @driver = Driver.find_by(id: params[:id])
    @driver.mark_unavailable
  end

  private

  def driver_params
    return params.require(:driver).permit(:name, :vin, :available).with_defaults(available: true)
  end
end
