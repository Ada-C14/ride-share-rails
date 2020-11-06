require "test_helper"

describe Trip do
  before do
    @passenger = Passenger.create(name: "Testing passenger",
                                  phone_num: "000-111-4567"
    )

    @driver = Driver.create(name: "Dr. Kenton Berge",
                            vin: "12345678901234567",
                            available: false
    )
  end
  let (:new_trip) {
    Trip.new(date: "2020-11-03", rating: 2, cost: 25.12, driver_id: @driver.id, passenger_id: @passenger.id )
  }
  it "can be instantiated" do

    expect(new_trip.valid?).must_equal true
  end

  it "will have the required fields" do
    # Arrange
    new_trip.save
    trip = Trip.first
    [:date, :rating, :passenger_id, :driver_id, :cost ].each do |field|
      expect(trip).must_respond_to field
    end
  end

  describe "relationships" do
    # Your tests go here
    it "belongs to one passenger" do
      new_trip.save

      expect(new_trip.passenger.name).must_equal @passenger.name
      expect(new_trip.passenger.id).must_equal @passenger.id
      expect(new_trip.passenger.phone_num).must_equal @passenger.phone_num
    end

    it "belong to one driver" do
      new_trip.save

      # assert
      expect(new_trip.driver.name).must_equal @driver.name
      expect(new_trip.driver.vin).must_equal @driver.vin
      expect(new_trip.driver.available).must_equal @driver.available
    end
  end

  describe "validations" do
    # Your tests go here
    it "must have an integer rating between 1 & 5 or nil" do
      new_trip.rating = 17
      expect(new_trip.valid?).must_equal false
      expect(new_trip.errors.messages).must_include :rating
      expect(new_trip.errors.messages[:rating]).must_equal ["must be less than or equal to 5"]

      new_trip.rating = 0
      expect(new_trip.valid?).must_equal false
      expect(new_trip.errors.messages).must_include :rating
      expect(new_trip.errors.messages[:rating]).must_equal ["must be greater than or equal to 1"]
    end

    it "must have a cost greater than 0" do
      new_trip.cost = -15.50
      expect(new_trip.valid?).must_equal false
      expect(new_trip.errors.messages).must_include :cost
      expect(new_trip.errors.messages[:cost]).must_equal ["must be greater than 0"]
    end
  end

  # Tests for methods you create should go here
  describe "custom methods" do
    describe "complete trip" do

      it "sets the driver to available when the trip is completed" do
        new_trip.save

        expect(new_trip.rating).must_equal 2

        new_trip.complete_trip
        new_trip.reload

        # assert
        expect(new_trip.driver.available).must_equal true

      end

      it "sets the driver to unavailable when rating is nil" do
        new_trip.save
        new_trip.update(rating: nil)
        new_trip.reload


        new_trip.complete_trip

        expect(new_trip.rating).must_be_nil
        expect(new_trip.driver.available).must_equal false
      end
    end
  end
end
