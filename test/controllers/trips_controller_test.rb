require "test_helper"

describe TripsController do
  before do
      Driver.create(name: "Test Driver", vin: "12345678912345678", available: true)
      Passenger.create(name: "Test Passenger", phone_num: "2065550000")
  end

  let (:trip) {
    Trip.create(date: "today",
                rating: nil,
                cost: 2560,
                passenger_id: Passenger.first.id,
                driver_id: Driver.first.id)
  }

  describe "show" do
    # Your tests go here
    # it "responds with success when showing an existing valid trip" do
    #   trip
    #   get trip_path(trip.id)
    #
    #   must_respond_with :success
    # end

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
