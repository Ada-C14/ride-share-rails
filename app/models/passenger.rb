class Passenger < ApplicationRecord
  has_many :trips

  validates :name, presence: true
  validates :phone_num, presence: true

  def total_spent
    sum = 0
    self.trips.each do |trip|
      sum += trip.cost
    end
    return (sum / 100).round(2)
  end

  def complete_trip
    @trip = self.trips.find_by(params[:passenger_id])
    @driver = Driver.find_by(@trip.driver_id)
    if @trip.rating.nil?
      @driver.update(available: true)
      redirect_to trip_path(params[:passenger_id])
    else

    end
    return
  end
end
