require "test_helper"

describe Trip do
  before(:all) do
    @test_driver = Driver.create(name: "Safety First", vin: "12345678901234567", available: true)
    @test_passenger = Passenger.create(name: "Sam Ple", phone_num: "555-555-5555")
    @test_trip = Trip.create(driver_id: @test_driver.id, passenger_id: @test_passenger.id, date: "11/11/2020", rating: 4, cost: 5000)
  end
  it "can be instantiated" do
    expect(@test_trip.valid?).must_equal true
  end

  it "will have the required fields" do
    trip = Trip.first
    [:driver_id, :passenger_id, :date, :rating, :cost].each do |field|

      expect(trip).must_respond_to field
    end

  end

  describe "relationships" do
    it "belongs to a driver" do
      expect(@test_trip.driver).must_be_instance_of Driver
    end

    it "belongs to a passenger" do
      expect(@test_trip.passenger).must_be_instance_of Passenger
    end

  end

  describe "validations" do

    it "must include a valid date (a string)" do
      @test_trip.date = nil

      expect(@test_trip.valid?).must_equal false
    end

    it "must include a cost" do
      @test_trip.cost = nil
      expect(@test_trip.valid?).must_equal false
    end

    it "must include a rating" do
      @test_trip.rating = nil
      expect(@test_trip.valid?).must_equal false
    end
  end

end
