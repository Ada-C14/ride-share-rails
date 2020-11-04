require "test_helper"

describe TripsController do
  let(:trip) {
    Trip.create(date: Date.today, driver_id: 2, passenger_id: 2, cost: 1234, rating: 4)
  }
  describe "show" do
    it "responds with success when showing an existing valid trip" do
      id = trip.id

      get trip_path(id)

      must_respond_with :success
    end

    it "responds with 404 with an invalid trip id" do
      get trip_path(-1)

      must_respond_with :not_found
    end
  end

  describe "create" do
    it "can create a new trip" do

    end
  end

  describe "edit" do

    it "responds with success when getting the edit page for a valid trip id" do
      id = trip.id

      get edit_trip_path(id)

      must_respond_with :success
    end

    it "responds with 404 when gettin gthe edit page with an invalid trip id" do
      id = -1

      get edit_trip_path(id)

      must_respond_with :not_found
    end
  end

  describe "update" do
    let (:trip_update) {
      {
          trip: {
              rating: 0
          }
      }
    }
    it "can update an existing trip" do
      id = trip.id

      expect {
        path trip_id(id), params: trip_update
      }.wont_change "Trip.count"

      must_redirect_to trip_path

      test_trip = Trip.find_by(id)
      expect(test_trip.rating).must_equal trip_update[:trip][:rating]

    end

    it "does not update a trip if given an invalid id" do
      id = -1

      expect {
        patch trip_path(id), params: trip_update
      }.wont_change "Trip.count"

      must_respond_with :not_found
    end
  end

  describe "destroy" do
    it "destroys the driver database record when the driver exists and redirects" do
      id = trip.id
      passenger_id = trip.passenger.id
      expect {
        delete trip_path(id)
      }.must_change "Trip.count", -1

      must_redirect_to passenger_path(passenger_id)
    end

    it"does not change db when the driver id is invalid" do
      id = -1

      expect {
        delete trip_path(id)
      }.wont_change "Trip.count"

      must_respond_with :not_found
    end
  end
end

