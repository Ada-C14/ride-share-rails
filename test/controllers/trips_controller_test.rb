require "test_helper"

describe TripsController do
  let (:driver) {
    {name: "John Smith", vin: "WBWSS52P9NEYLVDE9", available: true}
  }
  let (:passenger) {
    {name: "John Smith", phone_num: "560.815.3059"}
  }
  before do
    @driver = Driver.create!(driver)
    @passenger = Passenger.create!(passenger)
  end

  describe "index" do
    it "responds with success when there are trips saved" do
      # Arrange
      # Ensure that there is at least one Trip saved (before block)
      trip_1 = Trip.create!(passenger_id: @passenger.id, driver_id: @driver.id, rating: 5, cost: 1234)
      # Act
      get trips_path
      # Assert
      must_respond_with :success
    end

    it "responds with success when there are no trips saved" do
      # Arrange
      # Ensure that there are zero trips saved

      # Act
      get trips_path
      # Assert
      must_respond_with :success
    end
  end
  describe "show" do
    it "responds with success when showing an existing valid trip" do
      # Arrange
      # Ensure that there is a trip saved
      trip_1 = Trip.create!(passenger_id: @passenger.id, driver_id: @driver.id, rating: 5, cost: 1234)
      # Act
      get trip_path(trip_1.id)
      # Assert
      must_respond_with :success
    end

    it "redirects to index when given an invalid trip id" do
      get trip_path(-1)

      must_redirect_to trips_path
    end

  end

  describe "create" do
    let (:trip_hash) {
      {trip: {
          passenger_id: @passenger.id,
          driver_id: @driver.id,
          rating: 5,
          cost: 1234
      }
      }}
    it "can create a new driver with valid information accurately, and redirect" do

      expect {
        post trips_path, params: trip_hash
      }.must_change "Trip.count", 1

      new_trip = Trip.find_by(passenger_id: trip_hash[:trip][:passenger_id])
      expect(new_trip.passenger_id).must_equal trip_hash[:trip][:passenger_id]

      must_respond_with :redirect
      must_redirect_to trip_path(new_trip.id)
    end

    it "does not create a trip if the form data violates Trip validations, and responds with a redirect" do
      trip_hash[:trip][:passenger_id] = nil

      expect { post trips_path, params: trip_hash
      }.wont_change "Trip.count"

      must_respond_with :success
    end
  end

  describe "edit" do
    it "responds with success when getting the edit page for an existing, valid trip" do
      # Arrange
      # Ensure there is an existing trip saved
      trip_1 = Trip.create!(passenger_id: @passenger.id, driver_id: @driver.id, rating: 5, cost: 1234)

      # Act
      get edit_trip_path(trip_1.id)

      # Assert
      must_respond_with :success
    end

    it "responds with redirect when getting the edit page for a non-existing trip" do
      # Arrange
      # Ensure there is an invalid id that points to no trip
      # Act
      get edit_trip_path("bad path")
      # Assert
      must_respond_with :not_found
    end
  end

  describe "update" do
    let (:trip_hash) {
      {trip: {
          passenger_id: @passenger.id,
          driver_id: @driver.id,
          rating: 5,
          cost: 1234
      }
      }}
    let (:new_hash) {
      {trip: {
          passenger_id: @passenger.id,
          driver_id: @driver.id,
          rating: 5,
          cost: 9876
      }
      }}
    it "can update an existing trip with valid information accurately, and redirect" do

      post trips_path, params: trip_hash
      new_trip = Trip.find_by(passenger_id: trip_hash[:trip][:passenger_id])

      expect {
        patch trip_path(new_trip.id), params: {trip: { cost: 9876 } }
      }.wont_change "Trip.count"

      new_trip.reload
      expect(new_trip.cost).must_equal new_hash[:trip][:cost]
      expect(new_trip.rating).must_equal new_hash[:trip][:rating]

      must_redirect_to trip_path(new_trip.id)
    end

    # it "does not update any passenger if given an invalid id, and responds with a 404" do
    #
    #   patch passenger_path(656676)
    #   must_respond_with :not_found
    # end
    #
    # it "does not edit a passenger if the form data violates Passenger validations, and responds with a redirect" do
    #
    #   passenger = Passenger.first
    #
    #   expect {
    #     patch passenger_path(passenger.id), params: {passenger: { phone_num: ''} }
    #   }.wont_change "passenger.phone_num"
    # end
  end

  describe "destroy" do
    # Your tests go here
  end
end
