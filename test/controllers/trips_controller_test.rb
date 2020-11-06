require "test_helper"

describe TripsController do
  before do
    @driver = Driver.create(
        {
            name: "Kim Vitug",
            vin: "FDSGB3245TERSD",
            available: true
        }
    )
    @passenger = Passenger.create(
        {
            name: "Sophie Messing",
            phone_num: "555-555-5555"
        }
    )
    @trip = Trip.create(
        {
            date: Date.today,
            rating: 4,
            cost: 1865,
            passenger_id: @passenger.id,
            driver_id: @driver.id
        }
    )
  end

  describe "show" do
    it "responds with success when showing an existing trip" do

      # Act
      get trip_path(@trip.id)

      # Assert
      must_respond_with :success
    end

    it "responds with 404 with an invalid trip id" do
      # Arrange
      invalid_id = -1

      # Act
      get trip_path(invalid_id)

      # Assert
      must_respond_with :not_found
    end
  end

  describe "create" do
    before do
      @driver = Driver.create!(
          {
              name: "Kim Vitug",
              vin: "FDSGB3245TERSD",
              available: true
          }
      )
      @passenger = Passenger.create!(
          {
              name: "Sophie Messing",
              phone_num: "555-555-5555"
          }
      )
      @trip = Trip.create!(
          {
              date: Date.today,
              rating: 4,
              cost: 1865,
              passenger_id: @passenger.id,
              driver_id: @driver.id
          }
      )
    end

    it "can create a new trip with valid information accurately, and redirect" do

    end

    it "does not create a trip if the form data violates Passenger validations, and responds with bad request" do

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
