require "test_helper"

describe Trip do
  let (:new_passenger) {
    Passenger.create(name: "Kari", phone_num: "111-111-1211")
  }

  let (:new_driver) {
    Driver.create(name: "Kim Vitug", vin: "FDSGB3245TERSD", available: true)
  }

  let (:new_trip) {
    Trip.create(date: Date.today, rating: 4, cost: 1865, passenger_id: new_passenger.id, driver_id: new_driver.id)
  }

  it "can be instantiated" do
    expect(new_trip.valid?).must_equal true
  end

  it "will have the required fields" do
    new_trip.save
    trip = Trip.first

    [:driver_id, :passenger_id, :date, :rating, :cost].each do |field|
      expect(trip).must_respond_to field
    end
  end

  describe "relationships" do
    # Your tests go here
  end

  describe "validations" do
    # Your tests go here
  end

  # Tests for methods you create should go here
  describe "custom methods" do
    # Your tests here
  end
end
