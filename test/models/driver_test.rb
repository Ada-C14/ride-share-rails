require "test_helper"

describe Driver do
  let (:new_driver) {
    Driver.new(name: "Kari", vin: "12312312312312312", available: true)
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
      new_driver.save

      # Assert
      expect(new_driver.valid?).must_equal false
      expect(new_driver.errors.messages).must_include :vin
      expect(new_driver.errors.messages[:vin]).must_equal ["can't be blank"]
    end
  end

  # Tests for methods you create should go here
  describe "custom methods" do
    before(:all) do
      @test_driver = Driver.create(name: "Safety First", vin: "12345678901234567", available: true)
      @test_passenger = Passenger.create(name: "Sam Ple", phone_num: "555-555-5555")
      @test_trip1 = Trip.create(driver_id: @test_driver.id, passenger_id: @test_passenger.id, date: "11/10/2020", rating: 1, cost: 1000)
      @test_trip2 = Trip.create(driver_id: @test_driver.id, passenger_id: @test_passenger.id, date: "11/11/2020", rating: 5, cost: 5000)
      @test_trip1.save
      @test_trip2.save
    end


    describe "average rating" do
      it "will calculate the average rating for a driver" do
        expect(@test_driver.average_rating).must_equal 3.0
      end
    end

    describe "gross earnings" do
      it "will calculate the gross earnings for a driver (total cost of trips)" do
        expect(@test_driver.gross_earnings).must_equal 60.0
      end

    end

    describe "net earnings" do

      it "will calculate the net earnings for a driver: 0.8 * (total cost - $1.65)" do
        expect(@test_driver.net_earnings).must_be_close_to 46.68

      end
    end

  end
end

