require "test_helper"

describe Trip do
  before do
    @driver = Driver.create(name: "Sanders", vin: "ABCDEFGHIJKLMNOPQ", available: true)
    @passenger = Passenger.create(name: "Sarah Verde", phone_num: "123-567-8765")
    @trip = Trip.create( driver_id: @driver.id, passenger_id: @passenger.id, date: Time.now, rating: nil, cost: 4567)
  end

  it "can be instantiated" do

    expect(@trip.valid?).must_equal true

  end

  it "will have the required fields" do



  end

  describe "relationships" do
    # Your tests go here
  end

  describe "validations" do
    before do
      #Arrange

    end
  end

  # Tests for methods you create should go here
  describe "custom methods" do
    # Your tests here
  end
end
