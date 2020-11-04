require "test_helper"

describe Trip do
  let (:new_trip) {
    Trip.new(driver_id: 1, passenger_id: 2, date: "11-03-2020", rating: 3, cost: 10)
  }
  it "can be instantiated" do
    # Your code here
  end

  it "will have the required fields" do
    # Your code here
  end

  describe "relationships" do
    # Your tests go here
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
      # expect(new_trip.errors.messages[:driver_id]).must_equal ["is not a number"] ASK ABOUT THIS
    end
    #
    # it "driver_id must be a number" do
    #   new_trip.driver_id = nil
    #
    #   expect(new_trip.valid?).must_equal false
    #   expect(new_trip.errors.messages).must_include :driver_id
    #   expect(new_trip.errors.messages[:driver_id]).must_equal ["is not a number"]
    # end

    it "must have a passenger_id" do
      # Arrange
      new_trip.passenger_id = nil

      # Assert
      expect(new_trip.valid?).must_equal false
      expect(new_trip.errors.messages).must_include :passenger_id
      expect(new_trip.errors.messages[:passenger_id]).must_equal ["can't be blank"]
      # expect(new_trip.errors.messages[:passenger_id]).must_be_type_of Integer ASK ABOUT THSI

    end

    it "must have a date" do
      # Arrange
      new_trip.date = nil

      # Assert
      expect(new_trip.valid?).must_equal false
      expect(new_trip.errors.messages).must_include :date
      expect(new_trip.errors.messages[:date]).must_equal ["can't be blank"]
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
