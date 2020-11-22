class Passenger < ApplicationRecord
  has_many :trips

  validates :name, presence: true

  validates :phone_num, presence: true # Don't worry about how a passenger's phone number is formatted

  def request_trip
    passenger_id = params[:id]
    new_trip = Trip.new(
        driver_id: first_available_driver.id,
        passenger_id: Passenger.find_by(id: passenger_id),
        date: Time.now,
        rating: nil,
        cost: 5
    )
    return new_trip
  end

  def total_charged
    total = 0

    trips.each do |trip|
      total += trip.cost
    end

    return total

  end

end

