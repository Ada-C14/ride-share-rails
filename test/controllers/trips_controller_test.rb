require "test_helper"

describe TripsController do


  let(:trip){
    Trip.create(date: Date.current)
  }

  let(:passenger){
    Passenger.create name: "sample passenger", phone_num: "999-999-9999"
  }

  describe "show" do

    it "can get a valid trip" do

      # Act
      get trip_path(trip.id)

      # Assert
      must_respond_with :success
    end

    it "will redirect for an invalid trip" do

      # Act
      get trip_path(-1)

      # Assert
      must_respond_with :redirect
    end
  end

  describe "create" do
    # Your tests go here
    it "can create a new trip" do

      Driver.create name: "Bernardo Prosacco", vin: "WBWSS52P9NEYLVDE9", available: true

      expect{
        post passenger_trips_path(passenger.id)
      }.must_change "Trip.count", 1

    end
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
