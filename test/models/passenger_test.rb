require "test_helper"

describe Passenger do
  let (:new_driver) {
    Driver.new(name: "Waldo", vin: "ALWSS52P9NEYLVDE9", available: "true")
  }

  let (:new_passenger) {
    Passenger.create(name: "Kari", phone_num: "111-111-1211")
  }

  let (:trip_1) {
    Trip.create(driver_id: new_driver.id, passenger_id: new_passenger.id, date: Date.today, rating: 5, cost: 12.34)
  }

  let (:trip_2) {
    Trip.create(driver_id: new_driver.id, passenger_id: new_passenger.id, date: Date.today, rating: 3, cost: 63.34)
  }

  it "can be instantiated" do
    # Assert
    expect(new_passenger.valid?).must_equal true
  end

  it "will have the required fields" do
    # Arrange
    new_passenger.save
    passenger = Passenger.first
    [:name, :phone_num].each do |field|

      # Assert
      expect(passenger).must_respond_to field
    end
  end

  describe "relationships" do
    it "can have many trips" do
      # Arrange
      new_passenger.save
      trip_1
      trip_2

      # Assert
      expect(new_passenger.trips.count).must_equal 2
      new_passenger.trips.each do |trip|
        expect(trip).must_be_instance_of Trip
      end
    end
  end

  describe "validations" do
    it "must have a name" do
      # Arrange
      new_passenger.name = nil

      # Assert
      expect(new_passenger.valid?).must_equal false
      expect(new_passenger.errors.messages).must_include :name
      expect(new_passenger.errors.messages[:name]).must_equal ["can't be blank"]
    end

    it "must have a phone number" do
      # Arrange
      new_passenger.phone_num = nil

      # Assert
      expect(new_passenger.valid?).must_equal false
      expect(new_passenger.errors.messages).must_include :phone_num
      expect(new_passenger.errors.messages[:phone_num]).must_equal ["can't be blank"]
    end
  end

  # Tests for methods you create should go here
  describe "custom methods" do
    it "total spent on rides:: returns 0 if no trips" do
      new_passenger.save
      expect(new_passenger.lifetime_cost).must_equal 0
    end

    it "total spent on rides: returns proper total spent if valid trips" do
      new_passenger.save
      trip_1
      trip_2
      expect(new_passenger.lifetime_cost).must_equal 75.68
    end
  end

    describe "complete trip" do
      # Your code here
    end
    # You may have additional methods to test here
end

