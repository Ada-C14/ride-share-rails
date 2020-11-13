require "test_helper"

describe Trip do
  let (:trip) {
    passenger = Passenger.create(name: "Passenger 1", phone_num: "555 555 5555")
    driver = Driver.create(name: "Driver 1", vin: "123456789")

    Trip.new(date: Date.today, passenger_id: passenger.id, driver_id: driver.id, cost: 300)
  }
  it "can be instantiated" do

    expect(trip.valid?).must_equal true
  end


  it "will have the required fields" do
    trip.save
    new_trip = Trip.first
    [:date, :passenger_id, :driver_id, :cost, :rating].each do |field|
      expect(new_trip).must_respond_to field
    end
  end

  describe "relationships" do
    it "belongs to only one passenger or driver" do
      passenger1 = Passenger.create(name: "Passenger 1", phone_num: "111111111")
      passenger2 = Passenger.create(name: "Passenger 2", phone_num: "222222222")
      driver = Driver.create(name: "Driver 1", vin: "1234567789")

      trip = Trip.create(date: Date.today, passenger_id: passenger1.id, driver_id: driver.id, rating: nil, cost: 500)

      expect(passenger1.trips.count).must_equal 1
      expect(passenger2.trips.count).must_equal 0
      expect(driver.trips.count).must_equal 1
    end
  end

  describe "validations" do
    # No validations
  end

  # Tests for methods you create should go here
  describe "custom methods" do
    # no custom methods
  end
end
