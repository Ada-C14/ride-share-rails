require "test_helper"

describe Trip do
  before do
    @passenger = Passenger.create!(name: "Kari", phone_num: 1111111)
    @driver = Driver.create(name: "Kari", vin: "123", available: true)
    @trip = Trip.create!(driver_id: @driver.id, passenger_id: @passenger.id, date: Time.now, rating: nil, cost: rand(1..1000))
  end
  it "can be instantiated" do
    expect(@trip.valid?).must_equal true
  end

  it "will have the required fields" do
    [:driver_id, :passenger_id, :date, :rating, :cost].each do |field|
      expect(@trip).must_respond_to field
    end
  end

  describe "relationships" do
    # Your tests go here
  end

  describe "validations" do
    # Your tests go here
  end

  # Tests for methods you create should go here
  describe "custom methods" do
    # Your tests here
  end
end
