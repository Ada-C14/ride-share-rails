require "test_helper"

describe TripsController do

  describe "show" do
      it "will get show for valid id" do

        driver = Driver.create(name: "Marta", vin: "RF5J464C70D9C3KBT")
        passenger = Passenger.create(name: "Mickey", phone_num: "2070772909")
        trip = Trip.create(driver_id: driver.id, passenger_id: passenger.id, date: Date.today, rating: 4, cost: 234)

        valid_trip_id = trip.id
        get "/trips/#{valid_trip_id}"

        must_respond_with :success
      end
  end

  describe "create" do
    # Your tests go here
  end

  describe "edit" do
    # Your tests go here
  end

  describe "update" do
    # Your tests go here
  end

  describe "destroy" do
    # Your tests go here
  end
end
