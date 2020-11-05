# require "test_helper"
#
describe TripsController do
  describe "show" do
    it "can get a valid trip" do
      # Act
      get "/trips"

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
    it "can create a new trip with valid information accurately, and redirect" do
      # Act-Assert
      expect {
        post trips_path, params: trip_hash
      }.must_change "Trip.count", 1

      new_trip =  Trip.find_by(driver_id: trip_hash[:trip][:driver_id])
      expect(new_trip.trip_id).must_equal trip_hash[:trip][:trip_id]
      expect(new_trip.date).must_equal trip_hash[:trip][:date]
      expect(new_trip.rating).must_equal trip_hash[:trip][:rating]
      expect(new_trip.cost).must_equal trip_hash[:trip][:cost]
      must_respond_with :redirect
      must_redirect_to trip_path(new_trip.id)
    end
 end

  describe "edit" do
    it "can get the edit page for an existing trip" do

      # #Act
      get "/trips"

      # Assert
      must_respond_with :ok
    end

    it "will respond with redirect when attempting to edit a nonexistant trip" do
      # Act
      get trip_path(-1)

      # Assert
      must_respond_with :redirect
    end
  end

  describe "update" do
    it "Does not change count and redirects to trip_path when trip id is valid" do

      # Arrange
      Trip.create(date: "09/15/2016", rating: nil, cost: 16.59)
      trip_hash = {
          trip: {
              date: "11/05/2020",
              rating: nil,
              cost: 32.53
          },
      }
      trip = Trip.first

      # Act-Assert
      expect {
        patch trip_path(trip.id), params: trip_hash
      }.must_differ "Trip.count", 0

      must_redirect_to trip_path
      expect(trip.last.date).must_equal trip_hash[:trip][:date]
      expect(trip.last.rating).must_equal trip_hash[:trip][:rating]
      expect(trip.last.cost).must_equal trip_hash[:trip][:cost]
    end

    it "will redirect to the root page if given an invalid id" do
      # Arrange
      Trip.create( date: "11/05/2020", rating: nil, cost: 32.53)
      trip_hash = {
          trip: {
              date: "11/05/2020",
              rating: nil,
              cost: 32.53
          },
      }
      trip = Trip.first

      # Act-Assert
      expect {
        patch trip_path(-1), params: trip_hash
      }.must_differ "Trip.count", 0

      must_respond_with :redirect
    end
  end

  describe "destroy" do
    it "Should delete an existing trip and redirect to the page" do
      # Arrange
      trip = Trip.new date: "09/15/2016", rating: 5.0, cost: 16.59

      trip.save
      trip = trip.id

      # Act
      expect {
        delete trip_path(trip)

        # Assert
      }.must_change 'Trip.count', -1

      trip = Trip.find_by_id(date: "09/15/2016")

      expect(trip).must_be_nil

      must_respond_with :redirect
      must_redirect_to trips_path
    end

    it "will respond with not_found for invalid ids" do

      expect {
        delete trip_path(-1)
      }.wont_change 'Trip.count'

      must_respond_with :redirect
    end
  end
end
