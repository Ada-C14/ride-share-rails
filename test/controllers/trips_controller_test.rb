require "test_helper"

describe TripsController do
  let (:new_driver) {
    Driver.new(name: "Kari", vin: "12345678901234567", available: true)
  }
  let (:new_passenger) {
    Passenger.new(name: "Terri", phone_num: "360-360-3600")
  }
  let (:new_trip) {
    Trip.new(driver_id: new_driver.id, passenger_id: new_passenger.id, cost: 2958, date: "2020-09-09", rating: 4)
  }

  describe "show" do
    it "responds with success for a valid trip" do
      new_driver.save
      new_passenger.save
      new_trip.save
      trip_id = new_trip.id

      get trip_path(trip_id)

      must_respond_with :success
    end

    it "redirects for an invalid trip" do
      invalid_id = -1

      get trip_path(invalid_id)

      must_respond_with :redirect
    end
  end

  describe "create" do
    it "creates a new trip with valid information" do
      new_driver.save
      new_passenger.save
      valid_hash = {
          trip: {
            driver_id: new_driver.id,
            passenger_id: new_passenger.id,
            cost: 5252,
            date: "2018-12-31",
            rating: 5
          }
      }

      expect {
        post trips_path, params: valid_hash
      }.must_differ "Trip.count", 1

      valid_trip = Trip.find_by(driver_id: valid_hash[:trip][:driver_id])

      expect(valid_trip.driver_id).must_equal valid_hash[:trip][:driver_id]
      expect(valid_trip.passenger_id).must_equal valid_hash[:trip][:passenger_id]
      expect(valid_trip.cost).must_equal valid_hash[:trip][:cost]
      expect(valid_trip.date).must_equal Date.parse(valid_hash[:trip][:date])
      expect(valid_trip.rating).must_equal valid_hash[:trip][:rating]
    end

    it "does not create a trip if the form data violates Trip validations" do
      invalid_hash = {
          trip: {
              driver_id: "",
              passenger_id: "",
              cost: "money",
              date: "now",
              rating: 1
          }
      }

      expect {
        post trips_path, params: invalid_hash
      }.wont_change Trip.count

      must_respond_with :bad_request
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
