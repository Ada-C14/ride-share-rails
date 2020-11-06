require "test_helper"

describe Trip do
  let (:passenger) {
    Passenger.create(name: "sample passenger", phone_num: "000-000-0000")
  }
  let (:driver) {
    Driver.create name: "sample driver", vin: "ghbgdsrklp2347bC9", available: true
  }
  let (:new_trip) {
    Trip.new(date: Time.now, rating: 4, driver_id: driver.id, passenger_id: passenger.id, cost: 2350)
  }
  it "can be instantiated" do
    expect(new_trip.valid?).must_equal true
  end

  it "will have the required fields" do
    # Arrange
    new_trip.save
    trip = Trip.first
    trip_fields = [:date, :rating, :driver_id, :passenger_id, :cost]
    trip_fields.each do |field|

      # Assert
      expect(trip).must_respond_to field
    end
  end

  describe "relationships" do
    before do
      @passenger = Passenger.create!(name: "test passenger", phone_num: "111-111-1111")
      @driver = Driver.create!(name: "test passenger", vin: "111", available: true)
      @trip = Trip.create(driver: @driver, passenger: @passenger, date: Date.today, rating: 5, cost: 1234)
    end
    it "belongs to passenger" do
      expect(@trip.passenger_id).must_equal @passenger.id
    end

    it "belongs to driver" do
      expect(@trip.driver_id).must_equal @driver.id
    end
  end

  describe "validations" do
    it "must have a date" do

    end

    it "must have a driver" do

    end

    it "must have a passenger" do

    end

    it "must have a cost" do

    end
  end

  # Tests for methods you create should go here
  describe "custom methods" do
    # Your tests here
  end
end
