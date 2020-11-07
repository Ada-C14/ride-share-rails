require "test_helper"

describe Trip do

  describe "can be instantiated" do

  it "can be instantiated" do
    driver = Driver.create(
        name: "Michael Schumacher",
        vin: "QWERTY99189",
        available: true )

    passenger = Passenger.create(
        name: "Mary Poppins",
        phone_num: "2064539189"
    )

    new_trip =  Trip.create(driver_id: driver.id, passenger_id: passenger.id, date: Date.today, rating: 5, cost: 1234)
    expect(new_trip.valid?).must_equal true
  end

    it "will have the required fields" do
      # Arrange
      #new_trip = Trip.first
      driver = Driver.create(
          name: "Michael Schumacher",
          vin: "QWERTY99189",
          available: true )

      passenger = Passenger.create(
          name: "Mary Poppins",
          phone_num: "2064539189"
      )

      new_trip =  Trip.create(driver_id: driver.id, passenger_id: passenger.id, date: Date.today, rating: 5, cost: 1234)
      [:passenger_id, :driver_id, :cost, :rating, :date].each do |field|
        expect(new_trip).must_respond_to field
      end
    end

  end


  describe "relationships" do
    it "can have one passenger:many to 1" do
      # Arrange

      driver = Driver.create(
          name: "Michael Schumacher",
          vin: "QWERTY99189",
          available: true )

      passenger = Passenger.create(
          name: "Mary Poppins",
          phone_num: "2064539189"
      )

      new_trip =  Trip.create(driver_id: driver.id, passenger_id: passenger.id, date: Date.today, rating: 5, cost: 1234)
      new_trip.passenger_id = passenger.id
      new_trip.driver_id = driver.id

      expect(new_trip.passenger_id).must_equal passenger.id
      #new_trip.passengers.each do |passenger|
      #expect(passenger).must_be_instance_of Passenger
      end
    end

  describe "validations" do

    it "must have a cost" do
      # Arrange
      driver = Driver.create(
          name: "Michael Schumacher",
          vin: "QWERTY99189",
          available: true )

      passenger = Passenger.create(
          name: "Mary Poppins",
          phone_num: "2064539189"
      )
      new_trip =  Trip.create(driver_id: driver.id, passenger_id: passenger.id, date: Date.today, rating: 5, cost: nil)

      # Assert
      expect(new_trip.valid?).must_equal false
      expect(new_trip.errors.messages).must_include :cost
    end

  end



end

