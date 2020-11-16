require "test_helper"

describe Trip do
  let (:new_driver) {
    Driver.new(name: "Kari", vin: "123", available: true)
  }
  let (:new_passenger) {
    Passenger.new(name: "Kari", phone_num: "111-111-1211")
  }
  let (:new_trip) {
    Trip.new(driver_id: new_driver.id, passenger_id: new_passenger.id, cost: 900, date: Date.today, rating: nil)
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
    [:driver_id, :passenger_id, :cost, :date, :rating].each do |field|

      # Assert
      expect(trip).must_respond_to field
    end
  end

  describe "relationships" do
    it "belongs to a passenger" do
      new_driver.save
      new_passenger.save
      new_trip.save

      trip = Trip.first
      passenger = Passenger.find_by(id: trip.passenger_id)

      expect(passenger).must_be_instance_of Passenger
    end

    it "belongs to a driver" do
      new_driver.save
      new_passenger.save
      new_trip.save

      trip = Trip.first
      driver = Driver.find_by(id: trip.driver_id)

      expect(driver).must_be_instance_of Driver
    end
  end

  describe "validations" do
    it "must have a cost" do
      # Arrange
      new_trip.cost = nil

      # Assert
      expect(new_trip.valid?).must_equal false
      expect(new_trip.errors.messages).must_include :cost
      expect(new_trip.errors.messages[:cost]).must_equal ["can't be blank"]
    end

    it "must have a date" do
      # Arrange
      new_trip.date = nil

      # Assert
      expect(new_trip.valid?).must_equal false
      expect(new_trip.errors.messages).must_include :date
      expect(new_trip.errors.messages[:date]).must_equal ["can't be blank"]
    end
  end

  # Tests for methods you create should go here
  describe "custom methods" do
    # Your tests here
  end
end
