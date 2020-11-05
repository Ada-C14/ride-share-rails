class DriversController < ApplicationController
  # Helper Methods
  def not_found_error_notice
    flash[:notice] = "Uh oh! That driver does not exist..."
    redirect_to drivers_path
  end

  def not_saved_error_notice
    flash[:notice] = "Uh oh! That did not save correctly."
  end

  #########################################################

  def index
    @drivers = Driver.order(:name).page(params[:page])
  end

  def show
    driver_id = params[:id].to_i
    @driver = Driver.find_by(id: driver_id)

    if @driver.nil?
      not_found_error_notice
      return
    end
  end

  def new
    @driver = Driver.new
  end

  def edit
    driver_id = params[:id].to_i
    @driver = Driver.find_by(id: driver_id)

    if @driver.nil?
      not_found_error_notice
      return
    end
  end

  def create
    @driver = Driver.new(driver_params)
    @driver.available = 'true'

    if @driver.save
      redirect_to driver_path(@driver.id)
      return
    end

    not_saved_error_notice
    render :new
    return
  end

  def update
    @driver = Driver.find_by(id: params[:id])

    if @driver.nil?
      not_found_error_notice
      return
    elsif @driver.update(driver_params)
      redirect_to driver_path
      return
    else
      not_saved_error_notice
      render :edit
      return
    end
  end

  def destroy
    @driver = Driver.find_by(id: params[:id])

    if @driver.nil?
      not_found_error_notice
      return
    else
      @driver.destroy
      redirect_to drivers_path
      return
    end
  end

  private

  def driver_params
    return params.require(:driver).permit(:name, :vin, :available)
  end
end
