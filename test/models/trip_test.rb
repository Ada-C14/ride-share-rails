require "test_helper"
require "pry"

describe Trip do
  before do
    @new_driver = Driver.create(name: "TEST123", vin: "WBWSS52P9NEYLVDE9", available: true)
    @new_passenger = Passenger.create(name: "Judy", phone_num: "360-555-0987")
  end

    let (:new_trip) {
      Trip.create(driver_id: @new_driver.id, passenger_id: @new_passenger.id, date: "2016-04-05", rating: 3, cost: 1293)
    }

  it "can be instantiated" do
    expect(new_trip.valid?).must_equal true
  end

  it "will have the required fields" do
    new_trip.save
    trip = Trip.first
    [:driver_id, :passenger_id, :date, :rating, :cost].each do |field|
      # Assert
      expect(trip).must_respond_to field
    end
  end

  describe "relationships" do
    it "can have one driver and one passenger" do
      # Arrange
      new_trip.save

      # Assert
      expect(new_trip.driver_id).must_equal @new_driver.id
      expect(new_trip.passenger_id).must_equal @new_passenger.id

    end
  end

  let (:invalid_trip) {
    Trip.create(driver_id: @new_driver.id, passenger_id: @new_passenger.id, date: "2016-04-05", rating: 50, cost: 1293)
  }

  describe "validations" do
    it "won't create a trip with an invalid rating" do
      expect(invalid_trip.valid?).must_equal false
    end
  end

end
