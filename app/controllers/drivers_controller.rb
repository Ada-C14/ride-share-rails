class DriversController < ApplicationController
  def index
    #give us all drivers
    @drivers = Driver.all.order(:id)
  end

  def show
    driver_id = params[:id].to_i
    @drivers = Driver.find_by(id:driver_id)

    if @drivers.nil?
      head :not_found # would a redirect be better here? Does it matter? It it my decision?
      return
    end
  end

  def new
    @drivers = Driver.new
  end

  def create
    # driver_params_results = driver_params
    # driver_params_results[:available] = true
    # @driver = Driver.new(driver_params_results
    # (name: params[:driver][:name], vin: params[:driver][:vin])
    @driver = Driver.new(driver_params)
    @driver.available = true

    if @driver.save
      redirect_to driver_path(@driver.id)
      return
    else
      render :new , status: :not_found
      return
    end
  end

  def edit
    @drivers = Driver.find_by(id:params[:id])

    if @drivers.nil?
      redirect_to drivers_path #Vs. Head :not_found
      return
    end
  end

  def update
    @drivers = Driver.find_by(id: params[:id])

    if @drivers.nil?
      head :not_found #redirect_to driver_path(@driver.id) # vs Head :not_found
      return
    elsif @drivers.update(name:params[:driver][:name],vin: params[:driver][:vin])
      redirect_to driver_path(@drivers.id)
      return
    else
      render :edit
      return
      end
  end

  def destroy
    driver_id = params[:id]
    @driver = Driver.find_by(id:driver_id)

    if @driver.nil?
      head :not_found
      return
    else
      @driver.destroy
      redirect_to drivers_path
    end
  end

  private
  # params = {id: 1, driver: {name: "hello world", author: becca}}
  #
  # params[:id]
  # params[:driver][:name]
  def driver_params
    return params.require(:driver).permit(:name, :vin, :available)
  end
end


