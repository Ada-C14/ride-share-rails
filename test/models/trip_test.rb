require "test_helper"

describe Trip do

  let (:passenger) {
    Passenger.create(name: "Anna Laura", phone_num: "999-999-0000")
  }

  let (:driver) {
    Driver.create(name: "John Meyer", vin: "WEE7868967777", available: "true")
  }

  let (:trip_hash) {
    {
        driver_id: Trip.assign_driver,
        passenger_id: passenger.id,
        date: Time.now,
        rating: nil,
        cost: Trip.generate_cost
    }
  }

  let (:trip) {
    Trip.create(trip_hash)
  }

  describe "relationships" do
    it "belongs to a driver and a passenger" do
      # Arrange
      driver
      trip

      # Assert
      expect(Passenger.find_by(id: trip.passenger_id)).must_be_instance_of Passenger
      expect(Driver.find_by(id: trip.driver_id)).must_be_instance_of Driver
    end
  end

  describe "validations" do
    it "must have a rating between 1 and 5 on update" do
      # Arrange
      driver
      trip.rating = -5

      # Assert
      expect(trip.valid?).must_equal false
      expect(trip.errors.messages).must_include :rating
      expect(trip.errors.messages[:rating]).must_equal ["must be greater than or equal to 0",
                                                        "is not included in the list"]
    end

    it "must have a date" do
      driver
      trip.date = nil

      expect(trip.valid?).must_equal false
      expect(trip.errors.messages).must_include :date
    end

    it "must have a cost greater than 0" do
      driver
      trip.cost = -99.2

      expect(trip.valid?).must_equal false
      expect(trip.errors.messages).must_include :cost
    end

    it "must have a driver_id" do
      trip

      expect(trip.valid?).must_equal false
      expect(trip.errors.messages).must_include :driver_id
    end

    it "must have a passenger_id" do
      driver
      trip.passenger_id = nil

      expect(trip.valid?).must_equal false
      expect(trip.errors.messages).must_include :passenger_id
    end
  end

  # Tests for methods you create should go here
  describe "custom methods" do
    # Your tests here
  end
end
