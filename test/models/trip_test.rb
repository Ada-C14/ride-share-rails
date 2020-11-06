require "test_helper"

describe Trip do
  let (:new_trip) {
    Trip.new(driver_id: 1, passenger_id: 1, date: Date.today, rating: 3, cost: 1023)
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
      expect(new_trip.errors.messages[:driver_id]).must_equal ["can't be blank"]
    end

    it "must have a passenger" do
      new_trip.passenger_id = nil

      expect(new_trip.valid?).must_equal false
      expect(new_trip.errors.messages).must_include :passenger_id
      expect(new_trip.errors.messages[:passenger_id]).must_equal ["can't be blank"]
    end
  end

  # Tests for methods you create should go here
  describe "custom methods" do
    # Your tests here
  end
end
