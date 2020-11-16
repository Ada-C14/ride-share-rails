require "test_helper"

describe Driver do
  let (:new_driver) {
    Driver.new(name: "Kari", vin: "123", available: true)
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
      expect(new_driver.errors.messages[:vin]).must_equal ["can't be blank"]
    end
  end

  describe "custom methods" do
    describe "average rating" do
      it "returns the correct average rating" do
        passenger = Passenger.create(name: "Ed Sheeran", phone_num: "111-111-1211")
        driver = Driver.create(name: "Taylor Swift", vin: "ALWSS52P9NEYLVDE9")
        trip_1 = Trip.create(driver_id: driver.id, passenger_id: passenger.id, date: Date.today, rating: 5, cost: 1234)
        trip_2 = Trip.create(driver_id: driver.id, passenger_id: passenger.id, date: Date.today, rating: 3, cost: 6334)
        trip_3 = Trip.create(driver_id: driver.id, passenger_id: passenger.id, date: Date.today, rating: 3, cost: 6334)

        expect(driver.avg_rating).must_be_close_to 3.67
      end

      it "returns the correct average rating" do
        driver = Driver.create(name: "Selena Gomez", vin: "DAFHTSHBFADSFA")

        expect(driver.avg_rating).must_equal 0
      end
    end

    describe "total earnings" do
      it "returns the correct total earnings for each driver" do
        passenger = Passenger.create(name: "Ed Sheeran", phone_num: "111-111-1211")
        driver = Driver.create(name: "Taylor Swift", vin: "ALWSS52P9NEYLVDE9")

        trip_1 = Trip.create(driver_id: driver.id, passenger_id: passenger.id, date: Date.today, rating: 5, cost: 1234)
        trip_2 = Trip.create(driver_id: driver.id, passenger_id: passenger.id, date: Date.today, rating: 3, cost: 6334)
        trip_3 = Trip.create(driver_id: driver.id, passenger_id: passenger.id, date: Date.today, rating: 3, cost: 6334)

        expect(driver.total_earnings).must_be_close_to 107.26
      end

      it "returns the correct total earnings for each driver" do
        driver = Driver.create(name: "Justin Bieber", vin: "DGAGEWAGFGDSFG")

        expect(driver.total_earnings).must_equal 0
      end
    end
  end
end
