require "test_helper"

describe Trip do
  let (:new_passenger) {
    Passenger.create(name: "Kari", phone_num: "111-111-1211")
  }

  let (:new_driver) {
    Driver.create(name: "Kim Vitug", vin: "FDSGB3245TERSD", available: true)
  }

  let (:new_trip) {
    Trip.create(date: Date.today, rating: 4, cost: 1865, passenger_id: new_passenger.id, driver_id: new_driver.id)
  }

  it "can be instantiated" do
    expect(new_trip.valid?).must_equal true
  end

  it "will have the required fields" do
    new_trip.save
    trip = Trip.first

    [:driver_id, :passenger_id, :date, :rating, :cost].each do |field|
      expect(trip).must_respond_to field
    end
  end

  describe "relationships" do

  end

  describe "validations" do
    it "must have a date" do
      # Arrange
      new_trip.date = Date.tomorrow

      # Assert
      expect(new_trip.valid?).must_equal false
      expect(new_trip.errors.messages).must_include :date
      expect(new_trip.errors.messages[:date]).must_equal ["can't be blank"]
    end

    it "must have a cost" do
      # Arrange
      new_trip.cost = nil

      # Assert
      expect(new_trip.valid?).must_equal false
      expect(new_trip.errors.messages).must_include :cost
      expect(new_trip.errors.messages[:cost]).must_equal ["can't be blank", "is not a number"]
    end

    it "must have a passenger id" do
      # Arrange
      new_trip.passenger_id = nil

      # Assert
      expect(new_trip.valid?).must_equal false
      expect(new_trip.errors.messages).must_include :passenger_id
      expect(new_trip.errors.messages[:passenger_id]).must_equal ["can't be blank", "is not a number"]
    end

    it "must have a driver id" do
      # Arrange
      new_trip.driver_id = nil

      # Assert
      expect(new_trip.valid?).must_equal false
      expect(new_trip.errors.messages).must_include :driver_id
      expect(new_trip.errors.messages[:driver_id]).must_equal ["can't be blank", "is not a number"]
    end
  end

  # Tests for methods you create should go here
  describe "custom methods" do
    # Your tests here
  end
end
