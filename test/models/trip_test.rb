require "test_helper"

describe Trip do
  let (:new_trip) {
    driver = Driver.create(name: "Kari", vin: "123", availability_status: true)
    passenger = Passenger.create(name: "Kari", phone_number: "111-111-1211")
    Trip.create(date: Time.now, cost: 26.63, passenger_id: passenger.id, driver_id: driver.id)
  }

  it "can be instantiated" do
    # Your code here
    expect(new_trip.valid?).must_equal true
  end

  it "will have the required fields" do
    # Your code here
    new_trip.save
    trip = Trip.first

    [:cost, :date, :passenger_id, :driver_id, :rating].each do |field|
      expect(trip).must_respond_to field
    end
  end

  describe "relationships" do
    # Your tests go here

    it "belongs to a Driver" do

    end

    it "belongs to a Passenger" do

    end

  end

  describe "validations" do
    # Your tests go here
    it "must have a cost" do
      new_trip.cost = nil

      # Assert
      expect(new_trip.valid?).must_equal false
      expect(new_trip.errors.messages).must_include :cost
      expect(new_trip.errors.messages[:cost]).must_equal ["can't be blank"]
    end

    it "must have a rating do" do
      new_trip.date = nil

      # Assert
      expect(new_trip.valid?).must_equal false
      expect(new_trip.errors.messages).must_include :date
      expect(new_trip.errors.messages[:date]).must_equal ["can't be blank"]
    end

  #TODO: tests for required passenger and driver??

  end

  # Tests for methods you create should go here
  # describe "custom methods" do
  #   # Your tests here
  # end
end
