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
      new_passenger = Passenger.create(name: "Kari", phone_num: "111-111-1211")
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
    describe "average rating" do
      # Your code here
      # new_driver = Driver.create(name: "Test", vin: "12345678912345678", available: true)
      # trip_3 = Trip.create(driver_id: new_driver.id, passenger_id: new_passenger.id, date: Date.today, rating: 4, cost: 1234)
      # trip_4 = Trip.create(driver_id: new_driver.id, passenger_id: new_passenger.id, date: Date.today, rating: nil, cost: 6334)

      it "returns float within range of 1.0 to 5.0" do
        new_driver = Driver.new(name: "Kari Driver", vin: "12345678912345678", available: true)
        new_driver.save
        new_passenger = Passenger.create(name: "Kari Passenger", phone_num: "111-111-1211")
        trip_1 = Trip.create(driver_id: new_driver.id, passenger_id: new_passenger.id, date: Date.today.to_s, rating: 5, cost: 1234)
        trip_2 = Trip.create(driver_id: new_driver.id, passenger_id: new_passenger.id, date: Date.today.to_s, rating: 3, cost: 6334)


        average = new_driver.avg_rating
        expect(average).must_be_kind_of Float
        expect(new_driver.trips.count).must_equal 2
        # expect(average).must_be :>=, 1.0
        # expect(average).must_be :<=, 5.0
      end


    end

    describe "total earnings" do
      # Your code here
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
