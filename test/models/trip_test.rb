require "test_helper"

describe Trip do

  let (:new_trip) {
    Trip.new(date: Date.current, driver: Driver.new(name: "Kari", vin: "WBWSS52P9NEYLVDE9", available: false), passenger: Passenger.new(name: "Kari", phone_num: "111-111-1211"))
  }
  it "can be instantiated" do
    expect(new_trip.valid?).must_equal true
  end

  it "will have the required fields" do
    # Arrange
    new_trip.save
    trip = Trip.first
    [:date, :rating, :cost].each do |field|

      # Assert
      expect(trip).must_respond_to field
    end
  end

  describe "relationships" do
    it "can have a driver" do
      # Arrange
      new_trip.save

      # Assert
      expect(new_trip.driver).must_be_instance_of Driver
    end

    it "can have a passenger" do
      # Arrange
      new_trip.save

      # Assert
      expect(new_trip.passenger).must_be_instance_of Passenger
    end
  end

  describe "validations" do
    it "must have a date" do
      # Arrange
      new_trip.date = nil

      # Assert
      expect(new_trip.valid?).must_equal false
      expect(new_trip.errors.messages).must_include :date
      expect(new_trip.errors.messages[:date][0]).must_equal "can't be blank"
    end

    it "rating must be <= 5" do
      # Arrange
      new_trip.rating = 6

      # Assert
      expect(new_trip.valid?).must_equal false
      expect(new_trip.errors.messages).must_include :rating
      expect(new_trip.errors.messages[:rating][0]).must_equal "must be less than 6"
    end

    it "rating must be > 0" do
      # Arrange
      new_trip.rating = -1

      # Assert
      expect(new_trip.valid?).must_equal false
      expect(new_trip.errors.messages).must_include :rating
      expect(new_trip.errors.messages[:rating][0]).must_equal "must be greater than 0"
    end

    it "rating must be an integer" do
      new_trip.rating = 0.000000666

      # Assert
      expect(new_trip.valid?).must_equal false
      expect(new_trip.errors.messages).must_include :rating
      expect(new_trip.errors.messages[:rating][0]).must_equal "must be an integer"
    end

    it "cost must be an integer" do
      new_trip.cost = 0.000000666

      # Assert
      expect(new_trip.valid?).must_equal false
      expect(new_trip.errors.messages).must_include :cost
      expect(new_trip.errors.messages[:cost][0]).must_equal "must be an integer"
    end

    it "cost must be > 0" do
      # Arrange
      new_trip.cost = -1

      # Assert
      expect(new_trip.valid?).must_equal false
      expect(new_trip.errors.messages).must_include :cost
      expect(new_trip.errors.messages[:cost][0]).must_equal "must be greater than 0"
    end
  end


  describe "custom methods" do
    # Your tests here
  end
end
