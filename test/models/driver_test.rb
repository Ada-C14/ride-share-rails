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

  # Tests for methods you create should go here
  describe "custom methods" do
    before do
      @new_driver = Driver.create(name: "Mike", vin: "123", available: true)
      @new_passenger = Passenger.create(name: "Mike", phone_num: "111-111-1211")

    end
    let(:trip_1) {
      Trip.create(driver_id: @new_driver.id, passenger_id: @new_passenger.id, date: Date.today, rating: 5, cost: 1000)
    }
    let(:trip_2) {
      Trip.create(driver_id: @new_driver.id, passenger_id: @new_passenger.id, date: Date.today, rating: 3, cost: 6334)
    }
    let(:trip_3){
      Trip.create(driver_id: @new_driver.id, passenger_id: @new_passenger.id, date: Date.today, rating: 3, cost: 1234)
    }
    describe "average rating" do
      it "returns average rating" do
        trip_1
        trip_2
        trip_3
        expect(@new_driver.average_rating).must_be_close_to 3.7
      end

      it "returns 0 if there is no trip" do
        expect(@new_driver.average_rating).must_equal 0
    end
  end

  describe "total_revenue" do
    it "returns total_revenue" do
      trip_1

      expect(@new_driver.total_revenue).must_equal '$6.68'
    end

    it "returns total_revenue" do
      trip_1
      trip_2

      expect(@new_driver.total_revenue).must_equal '$56.04'
    end

    it "returns total_revenue" do
      trip_1
      trip_2
      trip_3

      expect(@new_driver.total_revenue).must_equal '$64.59'
    end

    it "returns 0.0 if there is no trip" do
      expect(@new_driver.total_revenue).must_equal 0.0
    end
  end

  describe "can go online" do
    # Your code here
  end

  describe "can go offline" do
    # Your code here
  end

  # You may have additional methods to test
end
end
