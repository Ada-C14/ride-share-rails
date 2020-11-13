require "test_helper"

describe Trip do
  before do
    Passenger.create(name: "Banana", phone_num: "123-123-1230")
    Driver.create(name: "Berry", vin:"123456780", available:true )
  end

  let (:new_trip) {
    Trip.new(driver_id: Driver.first.id, passenger_id: Passenger.first.id, date: Date.today, rating: 3, cost: 1023)
  }
  it "can be instantiated" do
    expect(new_trip.valid?).must_equal true
  end

  it "will have the required fields" do
    new_trip.save
    trip = Trip.first
    [:driver_id, :passenger_id, :date].each do |field|
      expect(trip).must_respond_to field
    end
  end

  # describe "relationships" do
  #   it "have a driver" do
  #
  #   end
  # end
  # #########Is it necessary to test relationship here? as trip only has one driver and one passenger.

  describe "validations" do
    it "must have a driver" do
      new_trip.driver_id = nil

      expect(new_trip.valid?).must_equal false
      expect(new_trip.errors.messages).must_include :driver_id
      expect(new_trip.errors.messages[:driver_id]).must_equal ["can't be blank", "is not a number"]
    end

    it "must have a passenger" do
      new_trip.passenger_id = nil

      expect(new_trip.valid?).must_equal false
      expect(new_trip.errors.messages).must_include :passenger_id
      expect(new_trip.errors.messages[:passenger_id]).must_equal ["can't be blank", "is not a number"]
    end
  end

  # Tests for methods you create should go here
  describe "request_trip" do
    it "will create a trip but not save to database" do
      Passenger.create(name: "Test", phone_num: "123-123-1234")
      Driver.create(name: "Peach", vin:"123456789", available:true )

      trip = Trip.request_trip(Passenger.last.id)
      expect { Trip.request_trip(Passenger.last.id)}.wont_change 'Trip.count'
      expect(trip.passenger_id).must_equal Passenger.last.id
    end
  end
end
