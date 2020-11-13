require "test_helper"

describe Driver do
  let (:new_driver) {
    Driver.new(name: "Kari", vin: "123ABCDEFGHIJKLMN", available: true)
  }

  let (:new_passenger) {
    Passenger.create(name: "Kari", phone_num: "111-111-1121")
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
      trip_1 = Trip.create(driver_id: new_driver.id, passenger_id: new_passenger.id, date: Date.today, rating: 5, cost: 1234)
      trip_2 = Trip.create(driver_id: new_driver.id, passenger_id: new_passenger.id, date: Date.today, rating: 3, cost: 6334)

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
    let (:driver_2) {
      Driver.create(name: "No Trips", vin: "00000000000000000", available: true)
    }

    describe "average rating" do
      it "returns float within range of 1.0 to 5.0 and correctly calculates average rating" do
        new_driver.save
        trip_1 = Trip.create(driver_id: new_driver.id, passenger_id: new_passenger.id, date: Date.today, rating: 5, cost: 1234)
        trip_2 = Trip.create(driver_id: new_driver.id, passenger_id: new_passenger.id, date: Date.today, rating: 3, cost: 6334)
        average = new_driver.avg_rating

        expect(average).must_be_kind_of Float
        expect(average).must_be :>=, 1.0
        expect(average).must_be :<=, 5.0
        expect(average).must_be_close_to 4.0, 0.01
      end

      it "ignores in progress trips with no rating" do
        new_driver.save
        trip_3 = Trip.create(driver_id: new_driver.id, passenger_id: new_passenger.id, date: Date.today, rating: 2, cost: 1234)
        trip_4 = Trip.create(driver_id: new_driver.id, passenger_id: new_passenger.id, date: Date.today, rating: nil, cost: 6334)
        average = new_driver.avg_rating

        expect(average).must_be_close_to 2.0, 0.01
      end

      it "returns zero if no driven trips" do
        expect(driver_2.avg_rating).must_equal 0
      end

    end

    describe "total earnings" do
      it "returns a float and correctly calculates total earnings" do
        new_driver.save
        trip_1 = Trip.create(driver_id: new_driver.id, passenger_id: new_passenger.id, date: Date.today, rating: 5, cost: 1234)
        trip_2 = Trip.create(driver_id: new_driver.id, passenger_id: new_passenger.id, date: Date.today, rating: 3, cost: 6334)
        earnings = new_driver.total_earnings

        expect(earnings).must_be_kind_of Float
        expect(earnings).must_be_close_to 0.8 * (1234 + 6334 - 2 * 165), 0.01
      end

      it "returns zero if no driven trips" do
        expect(driver_2.total_earnings).must_equal 0
      end

      it "returns zero if trip cost <= $1.65" do
        trip_1 = Trip.create(driver_id: driver_2.id, passenger_id: new_passenger.id, date: Date.today, rating: 4, cost: 100)

        expect(driver_2.total_earnings).must_equal 0
      end
    end

    # describe "can go online" do  -- DID NOT CREATE THIS METHOD --
    #   # Your code here
    # end
    #
    # describe "can go offline" do  -- DID NOT CREATE THIS METHOD --
    #   # Your code here
    # end

    # You may have additional methods to test
  end
end
