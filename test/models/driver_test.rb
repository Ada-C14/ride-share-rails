require "test_helper"

describe Driver do
  let (:new_driver) {
    Driver.new(name: "Kari", vin: "123", available: true)
  }
  it "can be instantiated" do
    # Assert
    expect(new_driver.valid?).must_equal true
  end

  it "will have the required fields" do
    # Arrange
    new_driver.save
    driver = Driver.first
    [:name, :vin, :available].each do |field|

      # Assert
      expect(driver).must_respond_to field
    end
  end

  describe "relationships" do
    it "can have many trips" do
      # Arrange
      new_driver.save
      new_passenger = Passenger.create(name: "Kari", phone_num: "111-111-1211")
      trip_1 = Trip.create(driver_id: new_driver.id, passenger_id: new_passenger.id, date: Date.today, rating: 5, cost: 1234)
      trip_2 = Trip.create(driver_id: new_driver.id, passenger_id: new_passenger.id, date: Date.today, rating: 3, cost: 6334)

      # Assert
      expect(new_driver.trips.count).must_equal 2
      new_driver.trips.each do |trip|
        expect(trip).must_be_instance_of Trip
      end
    end
  end

  describe "validations" do
    it "must have a name" do
      # Arrange
      new_driver.name = nil

      # Assert
      expect(new_driver.valid?).must_equal false
      expect(new_driver.errors.messages).must_include :name
      expect(new_driver.errors.messages[:name]).must_equal ["can't be blank"]
    end

    it "must have a VIN number" do
      # Arrange
      new_driver.vin = nil

      # Assert
      expect(new_driver.valid?).must_equal false
      expect(new_driver.errors.messages).must_include :vin
      expect(new_driver.errors.messages[:vin]).must_equal ["can't be blank"]
    end
  end

  # Tests for methods you create should go here
  describe "average rating" do
    new_driver = Driver.create(name: "Driver 1", vin: "123456")
    new_passenger = Passenger.create(name: "Kari", phone_num: "111-111-1211")
    trip_1 = Trip.create(driver_id: new_driver.id, passenger_id: new_passenger.id, date: Date.today, rating: 5, cost: 1234)
    trip_2 = Trip.create(driver_id: new_driver.id, passenger_id: new_passenger.id, date: Date.today, rating: 3, cost: 6334)


    it "calculates the average rating for a driver" do
      expect(new_driver.average_rating).must_equal 4.0
    end

    it "returns 0 if a driver has no trips" do
      driver = Driver.new(name: "Driver 1", vin: "12345")

      expect(driver.average_rating).must_equal 0
    end

  end

  describe "total earnings" do
    new_driver = Driver.create(name: "Driver 1", vin: "123456")
    new_passenger = Passenger.create(name: "Kari", phone_num: "111-111-1211")
    trip_1 = Trip.create(driver_id: new_driver.id, passenger_id: new_passenger.id, date: Date.today, rating: 5, cost: 1234)
    trip_2 = Trip.create(driver_id: new_driver.id, passenger_id: new_passenger.id, date: Date.today, rating: 3, cost: 6334)

    it "calculates the total earnings for a driver" do
      expect(new_driver.total_earnings).must_be_close_to 6051.76, 0.01
    end

    it "ignores trips costs less than 1.65" do
      trip3 = Trip.create(driver_id: new_driver.id, passenger_id: 5, date: Date.today, rating: 4, cost: 1.50)

      expect(new_driver.total_earnings).must_be_close_to 6051.76, 0.01
    end

    it "returns 0 if a driver has no trips" do
      driver = Driver.new(name: "Driver 1", vin: "12345")

      expect(driver.total_earnings).must_equal 0
    end
  end

  describe "select_driver" do
    it "returns an available driver" do

      selected_driver = Driver.select_driver

      expect(selected_driver.available).must_equal false

    end
  end
end
