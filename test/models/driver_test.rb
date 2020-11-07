require "test_helper"

describe Driver do
  let (:new_driver) {
    Driver.new(name: "Kari", vin: "12345678912345678", available: true)
  }
  it "can be instantiated" do
    # Assert
    expect(new_driver.valid?).must_equal true
  end

  it "will have the required fields" do
    # Arrange
    new_driver.save
    driver = Driver.first
    [:name, :vin, :available].each do |field|

      # Assert
      expect(driver).must_respond_to field
    end
  end

  describe "relationships" do
    it "can have many trips" do
      # Arrange
      new_driver.save
      new_passenger = Passenger.create!(name: "Kari", phone_num: "111-222-3333")
      trip_1 = Trip.create!(driver_id: new_driver.id, passenger_id: new_passenger.id, date: Date.today, rating: 5, cost: 1234)
      trip_2 = Trip.create!(driver_id: new_driver.id, passenger_id: new_passenger.id, date: Date.today, rating: 3, cost: 6334)

      # Assert
      expect(new_driver.trips.count).must_equal 2
      new_driver.trips.each do |trip|
        expect(trip).must_be_instance_of Trip
      end
    end
  end

  describe "validations" do
    it "must have a name" do
      # Arrange
      new_driver.name = nil

      # Assert
      expect(new_driver.valid?).must_equal false
      expect(new_driver.errors.messages).must_include :name
      expect(new_driver.errors.messages[:name]).must_equal ["can't be blank"]
    end

    it "must have a VIN number" do
      # Arrange
      new_driver.vin = nil

      # Assert
      expect(new_driver.valid?).must_equal false
      expect(new_driver.errors.messages).must_include :vin
      expect(new_driver.errors.messages[:vin]).must_equal ["can't be blank", "is the wrong length (should be 17 characters)"]
    end
  end

  # Tests for methods you create should go here
  describe "custom methods" do
    before do
      new_driver.save
      new_passenger = Passenger.create!(name: "Kari Passenger", phone_num: "222-333-4444")
      trip_1 = Trip.create!(driver_id: new_driver.id, passenger_id: new_passenger.id, date: Date.today.to_s, rating: 5, cost: 1234)
      trip_2 = Trip.create!(driver_id: new_driver.id, passenger_id: new_passenger.id, date: Date.today.to_s, rating: 3, cost: 6334)
    end

    describe "average rating" do
      it "returns float within range of 1.0 to 5.0" do
        average = new_driver.avg_rating
        expect(average).must_be_kind_of Float
        expect(average).must_be :>=, 1.0
        expect(average).must_be :<=, 5.0
        expect(average).must_equal 4.0
      end

      it "successfully ignores in-progress trips with no rating, and doesn't alter average" do
        new_p2 = Passenger.create!(name: "Second Passenger", phone_num: "333-444-5555")
        trip_3 = Trip.create!(driver_id: new_driver.id, passenger_id: new_p2.id, date: Date.today, rating: 4, cost: 1234)
        trip_4 = Trip.create!(driver_id: new_driver.id, passenger_id: new_p2.id, date: Date.today, rating: nil, cost: 6334)

        average = new_driver.avg_rating
        expect(average).must_equal 4.0
      end

      it "returns 0 if no trips" do
        d1 = Driver.create(name: "Test No Trips", vin: "12345678912345600", available: true)

        expect(d1.avg_rating).must_equal 0
      end

    end

    describe "total earnings" do
      it "returns float if trips" do
        revenue = new_driver.total_earnings
        expect(revenue).must_be_kind_of Float
      end

      it "returns 0 if no trips" do
        d1 = Driver.create(name: "Test No Trips", vin: "12345678912345600", available: true)

        expect(d1.total_earnings).must_equal 0
      end

      it "correctly calculates total revenue" do
        revenue = new_driver.total_earnings
        expect(revenue).must_be_close_to((1234-165 + 6334-165)*0.8)
      end

      it "returns 0 if trip cost <= 1.65" do
        d1 = Driver.create(name: "Test No Trips", vin: "12345678912345600", available: true)
        p1 = Passenger.create!(name: "Second Passenger", phone_num: "333-444-5555")
        trip_1 = Trip.create!(driver_id: d1.id, passenger_id: p1.id, date: Date.today, rating: 4, cost: 50)

        expect(d1.total_earnings).must_equal 0
      end
    end

    # describe "can go online" do  -- DID NOT MAKE THESE AS METHODS --
    #   # Your code here
    # end
    #
    # describe "can go offline" do  -- DID NOT MAKE THESE AS METHODS --
    #   # Your code here
    # end

    # You may have additional methods to test
  end
end
