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
    it "does not create a trip if the form data violates Trip validations" do
      invalid_id = -1

      expect {
        post request_trip_path(invalid_id)
      }.wont_change "Trip.count"

      must_respond_with :redirect
    end

    it "can create a new trip when passenger requests one" do
      new_passenger.save
      new_driver.save

      expect {
        post request_trip_path(new_passenger.id)
      }.must_differ "Trip.count", 1

      expect(new_driver.available).must_equal false
      must_respond_with :redirect
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
      }.wont_change "Trip.count"

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
      }.wont_change "Trip.count"

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
      }.wont_change "Trip.count"

      must_respond_with :bad_request
    end

    it "sets driver back to available after trip completed" do
      new_driver.available = false
      new_driver.save
      new_passenger.save
      new_trip.rating = nil
      new_trip.save
      trip_id = new_trip.id

      new_info = {
          trip: {
              driver_id: new_driver.id,
              passenger_id: new_passenger.id,
              cost: 2958,
              date: "2020-09-09",
              rating: 3
          }
      }

      patch trip_path(trip_id), params: new_info

      expect new_driver.available = true
    end

    it "leaves driver unavailable if trip not completed" do
      new_driver.available = false
      new_driver.save
      new_passenger.save
      new_trip.rating = nil
      new_trip.save
      trip_id = new_trip.id

      new_info = {
          trip: {
              driver_id: new_driver.id,
              passenger_id: new_passenger.id,
              cost: "dollars",
              date: "2020-09-09",
              rating: 3
          }
      }

      patch trip_path(trip_id), params: new_info

      expect new_driver.available = false
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
      }.wont_change "Trip.count"

      must_respond_with :redirect
    end
  end

  describe "passenger_request_trip" do
    it "creates a new trip when a passenger requests one" do
      new_driver.save
      new_passenger.save

      params = new_passenger.request_trip

      expect(params[:driver_id]).must_equal new_driver.id
      expect(params[:passenger_id]).must_equal new_passenger.id
      expect(params[:cost]).must_be_kind_of Integer
      expect(params[:date]).must_be_kind_of Date
    end

    it "does not create a trip for an invalid passenger id" do
      raise NotImplementedError
    end
  end
end
