require "test_helper"

describe Driver do
  let (:new_driver) {
    Driver.new(name: "Kari", vin: "12345678901234567", available: true)
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
      trip_1.save
      trip_2.save

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
      it "correctly finds average for driver with multiple trips" do
        new_driver.save
        new_passenger = Passenger.create(name: "Kari", phone_num: "111-111-1211")
        trip_1 = Trip.create(driver_id: new_driver.id, passenger_id: new_passenger.id, date: Date.today, rating: 5, cost: 1234)
        trip_2 = Trip.create(driver_id: new_driver.id, passenger_id: new_passenger.id, date: Date.today, rating: 3, cost: 6334)
        trip_3 = Trip.create(driver_id: new_driver.id, passenger_id: new_passenger.id, date: Date.today, rating: nil, cost: 6334)
        trip_1.save
        trip_2.save
        trip_3.save

        average = new_driver.average_rating

        expect(average).must_equal 4.0
      end

      it "returns zero for driver with no rated trips" do
        new_driver.save

        average = new_driver.average_rating

        expect(average).must_equal 0
      end
    end

    describe "total earnings" do
      it "correctly totals the earnings of a driver with multiple trips" do
        new_driver.save
        new_passenger = Passenger.create(name: "Kari", phone_num: "111-111-1211")
        trip_1 = Trip.create(driver_id: new_driver.id, passenger_id: new_passenger.id, date: Date.today, rating: 5, cost: 1234)
        trip_2 = Trip.create(driver_id: new_driver.id, passenger_id: new_passenger.id, date: Date.today, rating: 3, cost: 6334)
        trip_3 = Trip.create(driver_id: new_driver.id, passenger_id: new_passenger.id, date: Date.today, rating: nil, cost: 786)
        trip_1.save
        trip_2.save
        trip_3.save

        payday = new_driver.total_earnings

        expect(payday).must_equal 62.87
      end

      it "accounts for trips costing less than fee" do
        new_driver.save
        new_passenger = Passenger.create(name: "Kari", phone_num: "111-111-1211")
        trip_1 = Trip.create(driver_id: new_driver.id, passenger_id: new_passenger.id, date: Date.today, rating: 5, cost: 100)
        trip_1.save

        payday = new_driver.total_earnings

        expect(payday).must_equal 0.80
      end

      it "returns 0 for a driver with no trips" do
        new_driver.save

        payday = new_driver.total_earnings

        expect(payday).must_equal 0
      end
    end

    describe "can go online" do
      it "changes unavailable driver's status to available" do
        offline_driver = Driver.new(name: "Gloria Swanson", vin: "12345678909876543", available: false)
        offline_driver.save

        offline_driver.toggle_available

        expect(offline_driver.available).must_equal true
      end
    end

    describe "can go offline" do
      it "changes available driver's status to unavailable" do
        new_driver.save

        new_driver.toggle_available

        expect(new_driver.available).must_equal false
      end
    end

    describe "select_available" do
      before do
        new_driver.save
        busy_driver = Driver.new(name: "Marlene Dietrich", vin: "10101010101010101", available: false)
        busy_driver.save
      end

      it "selects an available driver" do
        selected = Driver.select_available

        expect(selected.id).must_equal new_driver.id
      end

      it "changes selected driver's status to unavailable" do
        status = new_driver.available

        selected = Driver.select_available

        expect(selected.available).must_equal false
        expect(selected.available).wont_equal status
      end

      it "does something something clever if no drivers are available" do
        raise NotImplementedError
      end

      it "selects available driver with fewest trips" do
        newest_driver = Driver.new(name: "Marion Davies", vin: "12341234123412345", available: true)
        newest_driver.save
        passenger = Passenger.new(name: "Norma Talmadge", phone_num: "293-239-2398")
        passenger.save
        trip_1 = Trip.new(driver_id: new_driver.id, passenger_id: passenger.id, cost: 2938, date: "2020-02-02", rating: 3)
        trip_1.save

        selected = Driver.select_available

        expect(selected.name).must_equal newest_driver.name
      end
    end

    # You may have additional methods to test
  end
end
