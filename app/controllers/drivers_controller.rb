class DriversController < ApplicationController

  def index
    @drivers = Driver.all.order(:id)
  end

  def show
    driver_id = params[:id].to_i
    @driver = Driver.find_by(id: driver_id)

    if @driver.nil?
      render file: "#{Rails.root}/public/404.html", status: :not_found
      return
    end

  end

  def new
    @driver = Driver.new
  end

  def create
    @driver = Driver.new(driver_params)
    @driver.availability_status = true
    if @driver.save
      redirect_to driver_path(@driver.id)
      return
    else
      redirect_to drivers_path
      return
    end

  end

  def edit
    driver_id = params[:id]
    @driver = Driver.find_by(id: driver_id)

    if @driver.nil?
      render file: "#{Rails.root}/public/404.html", status: :not_found
      return
    end
  end

  def update
    driver_id = params[:id]
    @driver = Driver.find_by(id: driver_id)

    if @driver.nil?
      render file: "#{Rails.root}/public/404.html", status: :not_found
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

    if @driver.nil?
      render file: "#{Rails.root}/public/404.html", status: :not_found
      return
    end

    if @driver.destroy
      redirect_to drivers_path
      return
    else #if .destroy fails
    redirect_to driver_path(@driver.id)
    return
    end
  end

  private

  def driver_params
    return params.require(:driver).permit(:name, :vin, :availability_status)
  end

end
