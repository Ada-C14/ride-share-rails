require "test_helper"

describe TripsController do
  let (:driver) {
    Driver.create(name: "Test Driver", vin: "12345678912345678", available: true)
  }

  let (:passenger) {
    Passenger.create(name: "Test Passenger", phone_num: "206-555-5555")
  }

  let (:trip) {
    Trip.create(date: "2020-11-05",
                rating: nil,
                cost: 1000,
                passenger: passenger,
                driver: driver)
  }

  describe "show" do
    # Your tests go here
    it "responds with success when showing an existing valid trip" do
      get trip_path(trip.id)

      must_respond_with :success
    end

    it "responds with redirect with an invalid trip id" do
      get trip_path(-1)

      must_respond_with :redirect
      must_redirect_to root_path
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
