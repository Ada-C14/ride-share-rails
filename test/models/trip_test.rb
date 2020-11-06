require "test_helper"

describe Trip do
  let (:new_trip) {
    Trip.new(driver_id: driver.id, passenger_id: passenger.id, date: "11-03-2020", rating: 3, cost: 10)
  }
  it "can be instantiated" do
    expect(new_trip.valid?).must_equal true
  end

  it "will have the required fields" do
    new_trip.save
    trip = Trip.first
    %i[driver_id passenger_id date rating cost].each do |field|

      expect(trip).must_respond_to field
    end
  end

  describe "relationships" do
    it "can have a driver" do
      # Arrange
      new_driver.save
      new_driver = Driver.create(name: "Waldo", vin: "ALWSS52P9NEYLVDE9")
      trip_1 = Trip.create(driver_id: new_driver.id, passenger_id: new_passenger.id, date: Date.today, rating: 5, cost: 1234)


      # Assert
      expect(new_passenger.trips.count).must_equal 1
      new_passenger.trips.each do |trip|
        expect(trip).must_be trip_1
      end
    end

    it "can have a passenger" do
      # Arrange
      new_passenger.save
      new_driver = Driver.create(name: "Waldo", vin: "ALWSS52P9NEYLVDE9")
      trip_1 = Trip.create(driver_id: new_driver.id, passenger_id: new_passenger.id, date: Date.today, rating: 5, cost: 1234)


      # Assert
      expect(new_passenger.trips.count).must_equal 1
      new_passenger.trips.each do |trip|
        expect(trip).must_be_instance_of Trip
      end
    end
  end

  describe "validations" do
    # Your tests go here
    it "must have a driver_id" do
      # Arrange
      new_trip.driver_id = nil

      # Assert
      expect(new_trip.valid?).must_equal false
      expect(new_trip.errors.messages).must_include :driver_id
      expect(new_trip.errors.messages[:driver_id]).must_equal ["can't be blank"]
    end

    it "must have a passenger_id" do
      # Arrange
      new_trip.passenger_id = nil

      # Assert
      expect(new_trip.valid?).must_equal false
      expect(new_trip.errors.messages).must_include :passenger_id
      expect(new_trip.errors.messages[:passenger_id]).must_equal ["can't be blank"]

    end

    it "must have a date" do
      # Arrange
      new_trip.date = nil

      # Assert
      expect(new_trip.valid?).must_equal false
      expect(new_trip.errors.messages).must_include :date
      # expect(new_trip.errors.messages[:date]).must_equal ["can't be blank"]
    end

    it "must have a rating" do
      # Arrange
      new_trip.rating = nil

      # Assert
      expect(new_trip.valid?).must_equal false
      expect(new_trip.errors.messages).must_include :rating
      expect(new_trip.errors.messages[:rating]).must_equal ["can't be blank", "is not a number"]
      # expect(new_trip.errors.messages[:rating]).must_be_between 1..5 ASK ABOUT THIS

    end

    it "must have a cost" do
      # Arrange
      new_trip.cost = nil

      # Assert
      expect(new_trip.valid?).must_equal false
      expect(new_trip.errors.messages).must_include :cost
      expect(new_trip.errors.messages[:cost]).must_equal ["can't be blank", "is not a number"]
      #expect(new_trip.errors.messages[:cost]).must_be_greater_than 0

    end
  end

  # Tests for methods you create should go here
  describe "custom methods" do
    # Your tests here
  end
end
