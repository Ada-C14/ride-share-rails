class DriversController < ApplicationController

  def index
    @drivers = Driver.all
  end

  def show
    @driver = Driver.find_by(id: params[:id])
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
      redirect_to drivers_path(@driver.id) #send the user to the /tasks path
      return
    else
      render :new, status: :bad_request
      return
    end
  end

  def edit
    @driver = Driver.find_by(id: params[:id])
    if @driver.nil?
      redirect_to root_path
      return
    end
  end

  def update
    @driver = Driver.find_by(id: params[:id])
    if @driver.nil?
      head :not_found
      return
    elsif @driver.update(driver_params)
      redirect_to driver_path(@driver.id)
      return
    else
    # render :edit
    redirect_to root_path
    end
  end

  def destroy
    driver = Driver.find_by(id: params[:id])

    if driver.nil?
      head :not_found
      return
    else
      driver.destroy
      redirect_to drivers_path
    end
  end

  def set_available
    # @available_driver = Driver.is_available?
  end

  def set_unavailable
    driver.mark_available
  end

  private

  def driver_params
    return params.require(:driver).permit(:name, :vin, :available)
  end
end
