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
    it "responds with success when getting the edit page for a trip" do
      new_driver.save
      new_passenger.save
      new_trip.save
      trip_id = new_trip.id

      get trip_path(trip_id)

      must_respond_with :success
    end

    it "redirects when getting the edit page for a non-existent trip" do
      trip_id = -1

      get trip_path(trip_id)

      must_respond_with :redirect
    end
  end

  describe "update" do
    it "can update an existing trip with valid information" do
      new_driver.save
      new_passenger.save
      new_trip.save
      trip_id = new_trip.id

      new_info = {
          trip: {
              driver_id: new_driver.id,
              passenger_id: new_passenger.id,
              cost: 800,
              date: Date.today,
              rating: 1
          }
      }

      expect {
        patch trip_path(trip_id), params: new_info
      }.wont_change Trip.count

      updated_trip = Trip.find_by(id: trip_id)

      expect(updated_trip.driver_id).must_equal new_info[:trip][:driver_id]
      expect(updated_trip.passenger_id).must_equal new_info[:trip][:passenger_id]
      expect(updated_trip.cost).must_equal new_info[:trip][:cost]
      expect(updated_trip.date).must_equal new_info[:trip][:date]
      expect(updated_trip.rating).must_equal new_info[:trip][:rating]

      must_respond_with :redirect
    end

    it "does not update an invalid trip" do
      new_driver.save
      new_passenger.save
      trip_id = -1
      new_info = {
          trip: {
              driver_id: new_driver.id,
              passenger_id: new_passenger.id,
              cost: 500,
              date: Date.today,
              rating: 3
          }
      }

      expect {
        patch trip_path(trip_id), params: new_info
      }.wont_change Trip.count

      must_respond_with :redirect
    end

    it "does not update a trip if the form data violates Trip validations" do
      new_driver.save
      new_passenger.save
      new_trip.save
      trip_id = new_trip.id
      bad_info = {
          trip: {
              driver_id: 0,
              passenger_id: 0,
              cost: "money",
              date: 2020-11-01,
              rating: 1
          }
      }

      expect {
        patch trip_path(trip_id), params: bad_info
      }.wont_change Driver.count

      must_respond_with :bad_request
    end
  end

  describe "destroy" do
    it "destroys an existing trip and redirects" do
      new_driver.save
      new_passenger.save
      new_trip.save
      trip_id = new_trip.id

      expect {
        delete trip_path(trip_id)
      }.must_differ "Trip.count", -1

      must_respond_with :redirect

      deleted_trip = Trip.find_by(id: trip_id)
      expect(deleted_trip).must_be_nil
    end

    it "does not change the db for non-existent trip, and redirects" do
      trip_id = -1

      expect {
        delete trip_path(trip_id)
      }.wont_change Trip.count

      must_respond_with :redirect
    end
  end
end
