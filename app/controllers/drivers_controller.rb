class DriversController < ApplicationController

  def index
    #give us all drivers
    @drivers = Driver.all
  end

  def show
    driver_id = params[:id].to_i
    @driver = Driver.find_by(id:driver_id)

    if @driver.nil?
      head :not_found # would a redirect be better here? Does it matter? It it my decision?
      return
    end
  end

  def new
    @driver = Driver.new
  end

  def create
    # driver_params_results = driver_params
    # driver_params_results[:available] = true
    # @driver = Driver.new(driver_params_results
    @driver = Driver.new(name: params[:driver][:name], vin: params[:driver][:vin])
    if @driver.save
      redirect_to drivers_path(@driver.id)
      return
    else
      render :new
      return
    end
  end

  def edit
    @driver = Driver.find_by(id:params[:id])

    if @driver.nil?
      redirect_to driver_path(@driver.id) #Vs. Head :not_found
      return
    end
  end

  def update
    @driver = Driver.find_by(id: params[:id])

    if @driver.nil?
      redirect_to driver_path(@driver.id) # vs Head :not_found
      return
    elsif @driver.update(driver_params)
      redirect_to new_driver_path(@driver.id)
      return
    else
      render :edit
      return
      end
  end

  def destroy

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

