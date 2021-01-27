require "test_helper"

describe Trip do
  let (:passenger) {
    Passenger.new(name: "Kari", phone_num: "111-111-1211")
  }
  let (:driver) {
    Driver.new(name: "Kari", vin: "WBWSS52P9NEYLVDE9", available: true)
  }
  let (:trip) {
    Trip.new(passenger_id: passenger.id, driver_id: driver.id, rating: 5, cost: 1234)
  }
  before do
    passenger.save
    driver.save
    trip.save
  end
  it "can be instantiated" do
    expect(Trip.first).must_be_kind_of Trip
  end

  it "will have the required fields" do
    # Arrange
    trip = Trip.first
    [:passenger_id, :driver_id, :rating, :cost].each do |field|

      # Assert
      expect(trip).must_respond_to field
    end
  end

  describe "relationships" do
    it "can only have one driver" do
      expect(trip.driver).must_be_kind_of Driver
    end
    it "can only have one passenger" do
      expect(trip.passenger).must_be_kind_of Passenger
    end
  end

  describe "validations" do
    it "had a numeric cost" do
      trip.cost = "not a number"

      expect(trip.valid?).must_equal false
    end
  end

  # Tests for methods you create should go here
  describe "custom methods" do
    # NONE
  end
end
