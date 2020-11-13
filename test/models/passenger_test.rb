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
      new_driver = Driver.create(name: "Waldo", vin: "BCTSH52M8YERVGDK9")
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
    describe "trip cost for the passenger" do
      driver = Driver.create(name: "Ayesha", vin: "BCTSH52M8YERVGDK9")
      passenger = Passenger.create(name: "Roshni", phone_num: "111-111-1211")
      trip_1 = Trip.create(driver_id: driver.id, passenger_id: passenger.id, date: Date.today, rating: 1, cost: 50)
      trip_2 = Trip.create(driver_id: driver.id, passenger_id: passenger.id, date: Date.today, rating: 2, cost: 25)
      trip_3 = Trip.create(driver_id: driver.id, passenger_id: passenger.id, date: Date.today, rating: 5, cost: 50)

      it "calculates the total amount charged for passenger" do
        expect(passenger.net_expenditures).must_equal 125
      end
    end

    it "if the passenger has no trips, returns 0 " do
      passenger = Passenger.new(name: "Ayesha", phone_num: "111-111-1211")
      expect(passenger.net_expenditures).must_equal 0
    end
  end
end
