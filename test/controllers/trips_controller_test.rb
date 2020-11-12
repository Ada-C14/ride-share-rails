require "test_helper"

describe TripsController do
  before do
    @passenger = Passenger.create name: "Test Passenger", phone_num: "293-293-2938"
    @driver = Driver.create name: "Test Driver", vin: "29384nsf93neiv093", available: true

    @trip = Trip.create(
      driver_id: @driver.id,
      passenger_id: @passenger.id,
      cost: 12.95,
      date: "11/08/2020",
      rating: nil
    )
  end

  describe "show" do
    it "responds with success when showing an existing valid trip" do
      # Act
      get trip_path(@trip.id)

      # Assert
      must_respond_with :success
    end

    it "responds with 404 with an invalid invalid id" do
      get trip_path(-1)

      # Assert
      must_respond_with :not_found
    end
  end

  describe "create" do
    it "can create a new trip with valid information and redirect" do
      trip_hash = {
          trip: {
              driver_id: @driver.id,
              passenger_id: @passenger.id,
              cost: 12.95,
              date: "11/08/2020",
              rating: nil
          },
      }
      id = @passenger.id
      expect {
        post passenger_trips_path(id), params: trip_hash
      }.must_differ "Trip.count", 1

      must_respond_with :redirect
    end

  end

  describe "edit" do
    it "responds with success when getting the edit page for an existing, valid trip" do
      # Act
      get edit_trip_path(@trip.id)

      # Assert
      must_respond_with :success

    end

    it "responds with redirect when getting the edit page for a non-existing driver" do
      # Arrange
      # Ensure there is an invalid id that points to no driver

      # Act
      get edit_trip_path(-1)

      # Assert
      must_respond_with :redirect

    end
  end

  describe "destroy" do
    it "destroys the trip instance in db when trip exists, then redirects" do
      # Arrange
      # Ensure there is an existing driver saved
      id = @trip.id

      # Act-Assert
      # Ensure that there is a change of -1 in Driver.count
      expect {
        delete trip_path(id)
      }.must_change "Trip.count", -1

      # Assert
      # Check that the controller redirects
      deleted_trip = Trip.find_by(id: id)

      expect(deleted_trip).must_be_nil

      must_respond_with :redirect
      must_redirect_to root_path
    end

    it "does not change the db when the trip does not exist, then responds with redirect" do
      # Arrange
      # Ensure there is an invalid id that points to no driver
      @trip.destroy

      # Act-Assert
      # Ensure that there is no change in Driver.count
      expect {
        delete trip_path(@trip.id)
      }.wont_differ "Trip.count"

      # Assert
      # Check that the controller responds or redirects with whatever your group decides
      must_respond_with :redirect
      must_redirect_to root_path
    end
  end
end
