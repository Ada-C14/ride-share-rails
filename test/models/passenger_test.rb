require "test_helper"

describe Passenger do
  let (:new_passenger) {
    Passenger.new(name: "Kari", phone_num: "111-111-1211")
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
      new_driver = Driver.create(name: "Waldo", vin: "ALWSS52P9NEYLVDE9")
      trip_1 = Trip.create(driver_id: new_driver.id, passenger_id: new_passenger.id, date: Date.today, rating: 5, cost: 1234)
      trip_2 = Trip.create(driver_id: new_driver.id, passenger_id: new_passenger.id, date: Date.today, rating: 3, cost: 6334)

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
    let (:new_driver) {
      Driver.new(name: "Carrie", vin: "11112222333344445", available: true)
    }

    it "correctly gives the total charged for all the passenger's trips" do
      new_passenger.save

      new_driver = Driver.create(name: "Waldo", vin: "ALWSS52P9NEYLVDE9")
      trip_1 = Trip.create(driver_id: new_driver.id, passenger_id: new_passenger.id, date: Date.today, rating: 5, cost: 1234)
      trip_2 = Trip.create(driver_id: new_driver.id, passenger_id: new_passenger.id, date: Date.today, rating: 3, cost: 6334)

      new_driver.save
      trip_2.save
      trip_1.save

      total = new_passenger.total_charged

      expect(total).must_equal 75.68
    end

    describe "request a trip" do
      it "returns a hash of trip parameters" do
        new_driver.save
        new_passenger.save
        new_trip = new_passenger.request_trip

        expect(new_trip).must_be_kind_of Hash
      end

      it "selects an available driver" do
        new_driver.save
        new_passenger.save
        new_trip = new_passenger.request_trip

        new_driver_id = new_driver.id
        hash_driver_id = new_trip[:driver_id]

        expect(new_driver_id).must_equal hash_driver_id
      end

      it "adds passenger id to the parameters" do
        new_driver.save
        new_passenger.save
        new_trip = new_passenger.request_trip

        new_passenger_id = new_passenger.id
        hash_passenger_id = new_trip[:passenger_id]

        expect(new_passenger_id).must_equal hash_passenger_id
      end

      it "assigns a cost to the parameters" do
        new_driver.save
        new_passenger.save
        new_trip = new_passenger.request_trip

        expect(new_trip[:cost]).must_be_kind_of Integer
      end

      it "assigns the current date to the parameters" do
        new_driver.save
        new_passenger.save
        new_trip = new_passenger.request_trip

        today = Date.today

        expect(new_trip[:date]).must_equal today
      end
    end

    describe "complete trip" do
      it "sets driver status to available" do
        new_passenger.save
        new_driver = Driver.create(name: "Waldo", vin: "ALWSS52P9NEYLVDE9", available: false)
        new_driver.save
        trip_1 = Trip.create(driver_id: new_driver.id, passenger_id: new_passenger.id, date: Date.today, rating: 5, cost: 1234)
        trip_1.save

        new_passenger.complete_trip(trip_1)

        driver = Driver.find_by(name: "Waldo")
        expect(driver.available).must_equal true
      end
    end
  end
end
