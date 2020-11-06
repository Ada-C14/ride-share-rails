class DriversController < ApplicationController
  def index
    @drivers = Driver.all
  end

  def show
    @driver = Driver.find_by(id: params[:id])
    if @driver.nil?
      render :file => "#{Rails.root}/public/404.html",  layout: false, status: :not_found
      return
    end
  end

  def new
    @driver = Driver.new
  end

  def create
    @driver = Driver.new(driver_params) 
    if @driver.save 
      redirect_to drivers_path 
      return
    else 
      render :new, status: :bad_request 
      return
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
      render :file => "#{Rails.root}/public/404.html",  layout: false, status: :not_found
      return
    elsif @driver.update(driver_params)
      redirect_to driver_path(@driver.id) 
      return
    else 
      render :edit, status: :bad_request  
      return
    end
  end

  def destroy
    @driver = Driver.find_by(id: params[:id])

    if @driver.nil?
      render :file => "#{Rails.root}/public/404.html",  layout: false, status: :not_found
      return
    end

    @driver.destroy

    redirect_to drivers_path
    return
  end

  private

  def driver_params
    return params.require(:driver).permit(:name, :vin, :available)
  end

end
