class Driver < ApplicationRecord
  has_many :trips
  has_many :passangers

  def index
    #give us all drivers
    @drivers =Driver.all
  end

  def create
    @driver=Driver.new(
        name: params[:driver][:name],
        vin: params[:driver][:vin]
    )
  end

  def update

  end

  def edit

  end

  def show

  end

  def destroy

  end

  private
  def driver_params
    return params.require(:driver).permit(:name, :vin, :available)
  end
end
