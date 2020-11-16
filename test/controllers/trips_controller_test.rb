require "test_helper"

describe TripsController do
  before(:all) do
    @test_driver = Driver.create(name: "Safety First", vin: "12345678901234567", available: true)
    @test_passenger = Passenger.create(name: "Sam Ple", phone_num: "555-555-5555")
    @test_trip = Trip.create(driver_id: @test_driver.id, passenger_id: @test_passenger.id, date: "11/11/2020", rating: 4, cost: 5000)
  end
  describe "show" do
    it "can get a valid trip path" do

      get trip_path(@test_trip.id)

      must_respond_with :success
    end

    it "can redirect if there's in invalid trip" do
      get trip_path(-1)

      must_respond_with :redirect
    end
  end

  describe "create" do
    it "can create a new trip" do

      trip_hash = {
          trip: {
              id: 1,
              driver_id: @test_driver.id,
              passenger_id: @test_passenger.id,
              date: "2016-04-05",
              rating: 4,
              cost: 1293
          },
      }

      expect {
        post trips_path, params: trip_hash
      }.must_change "Trip.count", 1

      new_trip = Trip.find_by(id: trip_hash[:trip][:id])
      expect(new_trip.id).must_equal trip_hash[:trip][:id]
      expect(new_trip.driver_id).must_equal trip_hash[:trip][:driver_id]
    end

  end

  describe "edit" do
    it "can get the edit page for an existing trip" do

      get edit_trip_path(@test_trip.id)

      must_respond_with :success
    end

    it "can redirect if trip to edit doesn't exist" do
      get edit_trip_path(-1)

      must_respond_with :redirect
    end
  end

  describe "update" do
    it "can update an existing trip" do
      trip_hash = {
          trip: {
              id: 3,
              driver_id: 2,
              passenger_id: 3,
              date: "2016-04-05",
              rating: 4,
              cost: 1293
          },
      }
      id = Trip.first.id

      expect {
        patch trip_path(id), params: trip_hash
      }.wont_change "Trip.count"

      must_respond_with :success

      trip_to_update = Trip.find_by(id: id)
      expect(trip_to_update.id).must_equal trip_hash[:trip][:id]
    end
  end

  describe "destroy" do
    it "destroys the trips instance in db when trip exists, then redirects" do
      # Arrange
      # Ensure there is an existing trip saved
      test_id = Trip.first.id

      # Act-Assert
      # Ensure that there is a change of -1 in Trip.count
      expect {
        delete trip_path(test_id)
      }.must_change "Trip.count", -1

      # Assert
      # Check that the controller redirects
      must_redirect_to root_path

    end

    it "does not change the db when the trip does not exist, then responds with redirect" do
      # Arrange
      # Ensure there is an invalid id that points to no trips

      # Act-Assert
      # Ensure that there is no change in Trip.count
      expect {
        delete trip_path(-1)
      }.wont_change "Trip.count"

      # Assert
      # Check that the controller responds or redirects with whatever your group decides
      must_respond_with :redirect
      must_redirect_to root_path
    end
  end
end
