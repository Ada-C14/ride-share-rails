require "test_helper"

describe Driver do
  let (:new_driver) {
    Driver.new(name: "Kari", vin: "WBWSS52P9NEYLVDE9", available: true)
  }
  it "can be instantiated" do
    # Assert
    expect(new_driver.valid?).must_equal true
  end

  it "will have the required fields" do
    # Arrange
    new_driver.save!
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
      expect(new_driver.errors.messages[:vin][0]).must_equal "can't be blank"
    end

    it "Vin number must be 17 characters" do
      # Arrange
      new_driver.vin = "2short"

      # Assert
      expect(new_driver.valid?).must_equal false
      expect(new_driver.errors.messages).must_include :vin
      d = new_driver.errors.messages
      expect(new_driver.errors.messages[:vin][0]).must_equal "is the wrong length (should be 17 characters)"
    end
  end

  # Tests for methods you create should go here
  describe "custom methods" do
    describe "average rating" do
      it "correctly calculates  average rating" do
        ratings = [1, 2, 3]
        expected_avg_rating = (ratings.sum/ratings.length).round

        new_passenger = Passenger.create(name: "Kari", phone_num: "111-111-1211")
        ratings.each{|rating| Trip.create!(rating: rating, cost:7777, date: Date.current, driver:new_driver, passenger: new_passenger)}

        expect(new_driver.avg_rating).must_equal expected_avg_rating
      end
    end

    describe "total earnings" do
      it "correctly calculates total earnings" do
        costs = [2000, 3000, 4000]
        expected_total_earnings = (costs.sum{|cost| cost - 165} * 0.8).round #7199

        new_passenger = Passenger.create!(name: "Kari", phone_num: "111-111-1211")
        costs.each{|cost| Trip.create!(cost:cost, date: Date.current, driver:new_driver, passenger: new_passenger)}

        expect(new_driver.total_earnings).must_equal expected_total_earnings
      end
    end

    describe "can go online" do
      it "toggle available from false to true" do
        new_driver.available = false

        new_driver.toggle_available

        expect(new_driver.available).must_equal true
      end
    end

    describe "can go offline" do
      it "toggle available from true to false" do
        new_driver.available = true

        new_driver.toggle_available

        expect(new_driver.available).must_equal false
      end
    end

  end
end