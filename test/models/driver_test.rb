require "test_helper"

describe Driver do
  let (:new_driver) {
    Driver.new(name: "Kari", vin: "123", availability_status: true)
  }
  it "can be instantiated" do
    # Assert
    expect(new_driver.valid?).must_equal true
  end

  it "will have the required fields" do
    # Arrange
    new_driver.save
    driver = Driver.first
    [:name, :vin, :availability_status].each do |field|

      # Assert
      expect(driver).must_respond_to field
    end
  end

  describe "relationships" do
    it "can have many trips" do
      # Arrange
      new_driver.save

      new_passenger = Passenger.create(name: "Kari", phone_number: "111-111-1211")
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
      @new_driver = Driver.create(name: "Kari", vin: "123", availability_status: true)
      new_passenger = Passenger.create(name: "Kari", phone_number: "111-111-1211")
      trip_1 = Trip.create(driver_id: @new_driver.id, passenger_id: new_passenger.id, date: Date.today, rating: 5, cost: 1234)
      trip_2 = Trip.create(driver_id: @new_driver.id, passenger_id: new_passenger.id, date: Date.today, rating: 3, cost: 6334)
      trip_3 = Trip.create(driver_id: @new_driver.id, passenger_id: new_passenger.id, date: Date.today, rating: 2, cost: 6334)
    end

    describe "average rating" do
      it "calculates correctly" do
        # Arrange
        # see before block

        #Act
        average_rating = @new_driver.average_rating

        #Assert
        expect(average_rating).must_be_kind_of Float
        expect(average_rating).must_be_close_to 3.33, 0.01
      end

      it "calculates correctly after a trip is deleted" do
        # Arrange
        # see before block

        expect {
          @new_driver.trips.first.destroy
        }.must_differ "@new_driver.trips.count", -1

        #Act
        average_rating = @new_driver.average_rating

        #Assert
        expect(average_rating).must_be_kind_of Float
        expect(average_rating).must_be_close_to 2.5, 0.01
      end

    end

    describe "total earnings" do
      # Your code here
      it "correctly calculates earnings" do
        total_earnings = @new_driver.total_earnings
        expected_earnings = 0.8 * (@new_driver.trips.sum { |trip| trip.cost - 1.65 })

        expect(total_earnings).must_be_kind_of Float
        expect(total_earnings).must_be_close_to expected_earnings, 0.01
      end

      it "returns 0 for a driver with no trips" do
        no_trips_driver = Driver.create(name: "New Driver", vin: "00000000999")
        expect(no_trips_driver.total_earnings).must_equal 0
      end

      it "correctly calculates earnings after a trip is deleted" do
        @new_driver.trips.last.destroy
        total_earnings = @new_driver.total_earnings
        expected_earnings = 0.8 * (@new_driver.trips.sum { |trip| trip.cost - 1.65 })

        expect(total_earnings).must_be_kind_of Float
        expect(total_earnings).must_be_close_to expected_earnings, 0.01
      end

    end

    describe "can go online" do
      it "changes an unavailable driver to available" do
        offline_driver = Driver.create(name: "New Driver", vin: "00000000999", availability_status: false)
        offline_driver.make_available
        expect(offline_driver.availability_status).must_equal true
      end
    end

    describe "can go offline" do
      it "changes an available driver to unavailable" do
        @new_driver.make_unavailable
        expect(@new_driver.availability_status).must_equal false
      end
    end

    describe "next available" do
      it "returns the next available driver from a list of new drivers (no trips)" do

        driver1 = Driver.create(name: "Mary", vin: "1565dsf", availability_status: true)
        driver2 = Driver.create(name: "Tom", vin: "15BJKHDf", availability_status: true)
        new_passenger = Passenger.create(name: "Kari", phone_number: "111-111-1211")
        Trip.create(cost: 34.34, date: Time.now, rating: nil, passenger_id: new_passenger.id, driver_id: driver2.id)
        next_driver = Driver.next_available

        expect(next_driver.name).must_equal driver1.name
        expect(next_driver.vin).must_equal driver1.vin
        expect(next_driver.availability_status).must_equal driver1.availability_status

        expect(next_driver.trips.count).must_equal 0
      end

      it "in the absence of new drivers, will select the driver with the longest time since last trip" do
        Driver.all.delete_all

        driver1 = Driver.create(name: "Mary", vin: "1565dsf", availability_status: true)
        driver2 = Driver.create(name: "Tom", vin: "15BJKHDf", availability_status: true)
        passenger = Passenger.create(name: "Kari", phone_number: "111-111-1211")

        trip_1 = Trip.create(driver_id: driver1.id, passenger_id: passenger.id, date: Date.today + 6.days, rating: 5, cost: 1234)
        trip_2 = Trip.create(driver_id: driver2.id, passenger_id: passenger.id, date: Date.today, rating: 3, cost: 6334)
        trip_3 = Trip.create(driver_id: driver2.id, passenger_id: passenger.id, date: Date.today, rating: 2, cost: 6334)

        next_driver = Driver.next_available
        expect(next_driver.name).must_equal driver1.name
        expect(next_driver.vin).must_equal driver1.vin
        expect(next_driver.availability_status).must_equal driver1.availability_status

      end

      # TODO: implement tests for logic for what to return in cases of no available drivers
    end


  end
end
