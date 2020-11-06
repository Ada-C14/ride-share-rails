require "test_helper"

describe TripsController do
  let (:new_trip) {
    Trip.new(date: Time.now + 5.days, cost: 5)
  }
  let (:trip_hash) {
    {
      trip: {
        date: Time.now + 6.days,
        cost: 5,
        rating: 4
      }
    }
  }
  describe "show" do
    it "can get a valid trip" do
      # Act
      get trip_path(new_trip.id)

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
    it "can create a new trip" do

      # Act-Assert
      expect {
        post trips_path, params: trip_hash
      }.must_change "Trip.count", 1

      new_trip = Trip.find_by(date: trip_hash[:trip][:date])
      expect(new_trip.cost).must_equal trip_hash[:trip][:cost]
      expect(new_trip.rating).must_equal trip_hash[:trip][:rating]

      must_respond_with :redirect
      must_redirect_to trip_path(new_trip.id)
    end
  end

  describe "edit" do
    it "can get the edit page for an existing trip" do
      # Act
      get edit_trip_path(trip.id)

      # Assert
      must_respond_with :success
    end

    it "will respond with redirect when attempting to edit a nonexistant task" do
      # Act
      get edit_trip_path(-1)

      # Assert
      must_respond_with :redirect
    end
  end

  describe "update" do
    it "can update an existing task" do
      trip = Trip.first
      expect {
        patch trip_path(trip.id), params: trip_hash
      }.wont_change "Trip.count"

      must_redirect_to root_path

      new_trip = Trip.find_by(date: trip_hash[:trip][:date])
      expect(new_trip.cost).must_equal trip_hash[:trip][:cost]
      expect(new_trip.rating).must_equal trip_hash[:trip][:rating]
    end

    it "will redirect to the root page if given an invalid id" do
      # Act
      patch trip_path(-1)

      # Assert
      must_respond_with :redirect
    end
  end

  describe "destroy" do
    it "can destroy an existing trip and redirect to the root page" do
      trip = Trip.first
      expect {
        delete trip_path(trip.id)
      }.must_differ 'Trip.count', -1

      must_redirect_to root_path
    end
  end
end

