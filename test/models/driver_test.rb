require "test_helper"

describe Driver do
  let (:new_driver) {
    Driver.new(name: "Kari", vin: "12345678901234567", available: true)
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
      expect(new_driver.errors.messages[:vin]).must_equal ["is the wrong length (should be 17 characters)"]
    end
  end

  # Tests for methods you create should go here
  describe "custom methods" do
    describe "average rating" do
      # Your code here
      it "accurately calculates the average rating of multiple trips" do
        new_driver.save
        new_passenger = Passenger.create(name: "Kari", phone_num: "111-111-1211")
        trip_1 = Trip.create(driver_id: new_driver.id, passenger_id: new_passenger.id, date: Date.today, rating: 5, cost: 1234)
        trip_2 = Trip.create(driver_id: new_driver.id, passenger_id: new_passenger.id, date: Date.today, rating: 3, cost: 6334)
        trip_3 = Trip.create(driver_id: new_driver.id, passenger_id: new_passenger.id, date: Date.today, rating: 1, cost: 1234)
        trip_4 = Trip.create(driver_id: new_driver.id, passenger_id: new_passenger.id, date: Date.today, rating: 4, cost: 6334)

        expect(new_driver.average_rating).must_be_close_to 3.3
      end

      it "accurately calculates the average rating of multiple trips even if there are nil ratings" do
        new_driver.save
        new_passenger = Passenger.create(name: "Kari", phone_num: "111-111-1211")
        trip_1 = Trip.create(driver_id: new_driver.id, passenger_id: new_passenger.id, date: Date.today, rating: 5, cost: 1234)
        trip_2 = Trip.create(driver_id: new_driver.id, passenger_id: new_passenger.id, date: Date.today, rating: 3, cost: 6334)
        trip_3 = Trip.create(driver_id: new_driver.id, passenger_id: new_passenger.id, date: Date.today, rating: nil, cost: 1234)
        trip_4 = Trip.create(driver_id: new_driver.id, passenger_id: new_passenger.id, date: Date.today, rating: 4, cost: 6334)

        expect(new_driver.average_rating).must_be_close_to 4
      end
    end

    describe "total earnings" do
      it "accurately calculates the total earnings of multiple trips" do
        new_driver.save
        new_passenger = Passenger.create(name: "Kari", phone_num: "111-111-1211")
        trip_1 = Trip.create(driver_id: new_driver.id, passenger_id: new_passenger.id, date: Date.today, rating: 5, cost: 12.34)
        trip_2 = Trip.create(driver_id: new_driver.id, passenger_id: new_passenger.id, date: Date.today, rating: 3, cost: 20.50)
        trip_3 = Trip.create(driver_id: new_driver.id, passenger_id: new_passenger.id, date: Date.today, rating: 1, cost: 15.65)
        trip_4 = Trip.create(driver_id: new_driver.id, passenger_id: new_passenger.id, date: Date.today, rating: 4, cost: 63.17)

        expect(new_driver.total_earnings).must_be_close_to 82.73
      end
    end

    describe "can go online" do
      it "can change availability to true from false" do
        new_driver.available = false
        new_driver.set_available
        expect(new_driver.available).must_equal true
      end
    end

    describe "can go offline" do
      # Your code here
      it "can change availability to false from true" do
        new_driver.save
        new_driver.set_unavailable
        expect(new_driver.available).must_equal false
      end
    end
  end
end
