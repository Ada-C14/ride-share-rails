require "test_helper"

describe Passenger do
  let (:new_passenger) {
    Passenger.new(name: "Kari", phone_number: "111-111-1211")
  }
  it "can be instantiated" do
    # Assert
    expect(new_passenger.valid?).must_equal true
  end

  it "will have the required fields" do
    # Arrange
    new_passenger.save
    passenger = Passenger.first
    [:name, :phone_number].each do |field|

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
      new_passenger.phone_number = nil

      # Assert
      expect(new_passenger.valid?).must_equal false
      expect(new_passenger.errors.messages).must_include :phone_number
      expect(new_passenger.errors.messages[:phone_number]).must_equal ["can't be blank"]
    end
  end

  # Tests for methods you create should go here
  describe "custom methods" do
    before do
      @new_passenger = Passenger.create(name: "Kari", phone_number: "111-111-1211")
    end

    describe "request a ride" do
      it "requests a ride" do
        requested_trip = @new_passenger.request_trip

        expect(requested_trip).must_be_kind_of Trip
        expect(requested_trip.valid?).must_equal true
        expect(requested_trip.passenger_id).must_equal @new_passenger.id
      end
    end

    #TODO: do we want to implement this?
    # describe "complete trip" do
    #
    # end

    describe "total charged" do
      before do
          Driver.create(name: "Waldo", vin: "ALWSS52P9NEYLVDE9", availability_status: true)
        @requested_trip1 = @new_passenger.request_trip
        @requested_trip1.save
        @requested_trip2 = @new_passenger.request_trip
        @requested_trip2.save
        @requested_trip3 = @new_passenger.request_trip
        @requested_trip3.save
      end

      it "correctly calculates total amount charged" do
        expected_total_charged = @requested_trip1.cost + @requested_trip2.cost + @requested_trip3.cost

        total_charged = @new_passenger.total_charged

        expect(total_charged).must_equal expected_total_charged
      end

      it "correctly calculates total amount charged when a trip is deleted" do
        @new_passenger.trips.last.destroy
        expected_total_charged = @requested_trip1.cost + @requested_trip2.cost

        total_charged = @new_passenger.total_charged

        expect(total_charged).must_be_close_to expected_total_charged, 0.01
      end

      it "returns 0 for passengers with no trips" do
        no_trip_passenger = Passenger.create(name: "Kari", phone_number: "111-111-1211")

        amount_charged = no_trip_passenger.total_charged

        expect(amount_charged).must_equal 0
      end
    end

  end
end
