require "test_helper"

describe TripsController do
  before do
    @passenger = Passenger.create name: "Test Passenger", phone_num: "293-293-2938"
    @driver = Driver.create name: "Test Driver", vin: "29384nsf93neiv093"

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
 
  end

  describe "edit" do
    it "responds with success when getting the edit a trip" do
      # Arrange
      # Ensure there is an existing passenger saved

      # Act
      get edit_trip_path(@trip.id)

      # Assert
      must_respond_with :success 
     end

  end

  describe "update" do
    # Your tests go here
  end

  describe "destroy" do
    # Your tests go here
  end
end
