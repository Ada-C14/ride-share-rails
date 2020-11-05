require "test_helper"

describe Trip do
  let (:new_driver) {
    Driver.new(name: "Kari", vin: "12345678901234567", available: true)
  }
  let (:new_passenger) {
    Passenger.new(name: "Terri", phone_num: "360-360-3600")
  }
  let (:new_trip) {
    Trip.new(driver_id: new_driver.id, passenger_id: new_passenger.id, cost: 2958, date: "2020-09-09", rating: 4)
  }

  it "can be instantiated" do
    new_driver.save
    new_passenger.save
    expect(new_trip.valid?).must_equal true
  end

  it "will have the required fields" do
    new_driver.save
    new_passenger.save
    new_trip.save
    trip = Trip.first
    [:driver_id, :passenger_id, :rating, :cost, :date].each do |field|
      expect(trip).must_respond_to field
    end
  end

  describe "relationships" do
    it "belongs to driver" do
      new_driver.save
      new_passenger.save
      new_trip.save
      trip = Trip.first

      driver_id = trip.driver_id
      driver = Driver.find_by(id: driver_id)

      expect(driver).must_be_instance_of Driver
    end

    it "belongs to passenger" do
      new_driver.save
      new_passenger.save
      new_trip.save
      trip = Trip.first

      passenger_id = trip.passenger_id
      passenger = Passenger.find_by(id: passenger_id)

      expect(passenger).must_be_instance_of Passenger
    end
  end

  describe "validations" do
    it "must have a date" do
      new_driver.save
      new_passenger.save
      new_trip.save

      new_trip.date = nil

      expect(new_trip.valid?).must_equal false
      expect(new_trip.errors.messages).must_include :date
      expect(new_trip.errors.messages[:date]).must_equal ["can't be blank"]
    end

    it "must have a cost" do
      new_driver.save
      new_passenger.save
      new_trip.save

      new_trip.cost = nil

      expect(new_trip.valid?).must_equal false
      expect(new_trip.errors.messages).must_include :cost
      expect(new_trip.errors.messages[:cost]).must_equal ["can't be blank", "is not a number"]
    end

    it "must have a cost that is a number" do
      new_driver.save
      new_passenger.save
      new_trip.save

      new_trip.cost = "ten"

      expect(new_trip.valid?).must_equal false
      expect(new_trip.errors.messages).must_include :cost
      expect(new_trip.errors.messages[:cost]).must_equal ["is not a number"]
    end

    it "must have a cost that is an integer" do
      new_driver.save
      new_passenger.save
      new_trip.save

      new_trip.cost = 10.50

      expect(new_trip.valid?).must_equal false
      expect(new_trip.errors.messages).must_include :cost
      expect(new_trip.errors.messages[:cost]).must_equal ["must be an integer"]
    end

    it "must have a driver" do
      new_driver.save
      new_passenger.save
      new_trip.save

      new_trip.driver_id = 0

      expect(new_trip.valid?).must_equal false
      expect(new_trip.errors.messages).must_include :driver
      expect(new_trip.errors.messages[:driver]).must_equal ["must exist", "can't be blank"]
    end

    it "must have a passenger" do
      new_driver.save
      new_passenger.save
      new_trip.save

      new_trip.passenger_id = 0

      expect(new_trip.valid?).must_equal false
      expect(new_trip.errors.messages).must_include :passenger
      expect(new_trip.errors.messages[:passenger]).must_equal ["must exist", "can't be blank"]
    end
  end

  # Tests for methods you create should go here
  describe "custom methods" do
    # Your tests here
  end
end
