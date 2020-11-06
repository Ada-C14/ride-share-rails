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
    it "can create a new trip with valid information and redirect" do
      driver_id = driver.id

      expect {
        post passenger_trips_path(passenger.id)
      }.must_change "Trip.count", 1

      new_trip = Trip.last
      Date.parse(new_trip.date)
      expect(new_trip.rating).must_be_nil
      expect(new_trip.cost >= 1000).must_equal true
      expect(new_trip.cost <= 3000).must_equal true
      expect(new_trip.passenger).must_equal passenger
      expect(new_trip.driver).must_equal driver

      expect(new_trip.driver.available).must_equal false

      must_respond_with :redirect
      must_redirect_to passenger_path(passenger.id)
    end

    it "won't create an invalid trip if no drivers available and will redirect" do
      driver.available = false
      driver.save

      # Act-Assert
      expect {
        post passenger_trips_path(passenger.id)
      }.wont_change "Trip.count"

      must_respond_with :temporary_redirect
      must_redirect_to passenger_path(passenger.id)
    end
  end

  describe "edit" do
    # Your tests go here
    it "can get the edit page for an existing trip" do
      get edit_trip_path(trip.id)

      must_respond_with :success
    end

    it "will respond with redirect when attempting to edit a nonexistent trip" do
      get edit_trip_path(-1)

      must_respond_with :redirect
      must_redirect_to root_path
    end
  end

  describe "update" do
    it "can update an existing trip" do
      trip_id = trip.id

      edited_trip_hash = {
          trip: {
              rating: 1
          }
      }

      expect {
        patch trip_path(trip_id), params: edited_trip_hash
      }.wont_change "Trip.count"

      edited_trip = Trip.find_by(id: trip_id)
      expect(edited_trip.rating).must_equal edited_trip_hash[:trip][:rating]

      must_respond_with :redirect
      must_redirect_to trip_path(trip_id)
    end

    it "won't update an existing trip if given invalid rating" do
      trip_id = trip.id

      edited_trip_hash = {
          trip: {
              rating: 10
          }
      }

      expect {
        patch trip_path(trip_id), params: edited_trip_hash
      }.wont_change "Trip.count"

      must_respond_with :bad_request
    end

    it "will redirect to the root page if given an invalid id" do
      patch trip_path(-1)

      must_respond_with :not_found
    end
  end

  describe "destroy" do
    it "can delete an existing trip with a rating" do
      trip.rating = 5
      trip.save

      expect {
        delete trip_path(trip.id)
      }.must_change "Trip.count", -1

      must_respond_with :redirect
      must_redirect_to passenger_path(trip.passenger)
    end

    it "won't delete an existing trip without a rating" do
      trip_id = trip.id

      expect {
        delete trip_path(trip_id)
      }.wont_change "Trip.count"

      must_respond_with :bad_request
    end

    it "will respond with not_found for invalid ids" do
      expect {
        delete trip_path(-1)
      }.wont_change "Trip.count"

      must_respond_with :not_found
    end
  end
end
