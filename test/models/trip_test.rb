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
      trip

      # Assert
      expect(Passenger.find_by(id: trip.passenger_id)).must_be_instance_of Passenger
      expect(Driver.find_by(id: trip.driver_id)).must_be_instance_of Driver
    end
  end

  describe "validations" do
    it "must have a rating between 1 and 5" do
      # Arrange
      new_passenger.name = nil

      # Assert
      expect(new_passenger.valid?).must_equal false
      expect(new_passenger.errors.messages).must_include :name
      expect(new_passenger.errors.messages[:name]).must_equal ["can't be blank"]
    end
  end

  # Tests for methods you create should go here
  describe "custom methods" do
    # Your tests here
  end
end
