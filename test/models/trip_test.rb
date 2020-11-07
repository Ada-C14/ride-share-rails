require "test_helper"

describe Trip do
  let (:driver) {
    Driver.create(name: "Test Driver", vin: "66666666666666666", available: true)
  }

  let (:passenger) {
    Passenger.create(name: "Test Passenger", phone_num: "666-666-6666")
  }

  let (:new_trip) {
    Trip.new(date: "2020-11-05",
                rating: nil,
                cost: 1000,
                passenger: passenger,
                driver: driver)
  }

  it "can be instantiated" do
    expect(new_trip.valid?).must_equal true
  end

  it "will have the required fields" do
    new_trip.save
    trip = Trip.first

    [:date, :rating, :cost, :passenger, :driver].each do |field|
      expect(trip).must_respond_to field
    end
  end

  describe "relationships" do
    it "belongs to a passenger" do
      # Arrange
      new_trip.save

      expect(new_trip.passenger).must_be_instance_of Passenger
      expect(new_trip.passenger).must_equal passenger
    end

    it "belongs to a driver" do
      new_trip.save

      expect(new_trip.driver).must_be_instance_of Driver
      expect(new_trip.driver).must_equal driver
    end
  end

  describe "rating validations" do
    it "must be less or equal to 5" do
      new_trip.rating = 6
      new_trip.save

      expect(new_trip.valid?).must_equal false
      expect(new_trip.errors.messages).must_include :rating
      expect(new_trip.errors.messages[:rating]).must_equal ["must be less than or equal to 5"]
    end

    it "must be greater than or equal to 1" do
      new_trip.rating = 0
      new_trip.save

      expect(new_trip.valid?).must_equal false
      expect(new_trip.errors.messages).must_include :rating
      expect(new_trip.errors.messages[:rating]).must_equal ["must be greater than or equal to 1"]
    end

    it "must be an integer" do
      new_trip.rating = "0/10 would not recommend"
      new_trip.save

      expect(new_trip.valid?).must_equal false
      expect(new_trip.errors.messages).must_include :rating
      expect(new_trip.errors.messages[:rating]).must_equal ["is not a number"]
    end
  end

  # Tests for methods you create should go here
  # describe "custom methods" do
  #   # Your tests here
  # end
end

