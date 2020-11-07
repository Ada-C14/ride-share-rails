require "test_helper"

describe TripsController do
  let (:trip) {
    Trip.create driver_id: "Driver 54", passenger_id: "Passenger 145", date: "2020/11/06", rating: 3, cost: 2300
  }
  describe "show" do
    it "responds with success when showing an existing trip" do
    # Arrange
    trip = Driver.new(name: "sample driver", vin: "ABC0000000000", available: true)
    trip.save
    # Act
    get trip_path(trip.id)
    # Assert
    must_respond_with :success
    end

    it "responds with success when showing an existing trip" do
      # Arrange
      # Act
      get trip_path(-1)
      # Assert
      must_respond_with :not_found
    end


  end

  describe "create" do
    it "an create a new trip with valid information, and redirect to the trip's details page" do
      # Arrange
      driver = Driver.create(
          name: "Michael Schumacher",
          vin: "QWERTY99189",
          available: true
      )
      driver.save

      passenger = Passenger.create(
          name: "Mary Poppins",
          phone_num: "2064539189"
          )
      passenger.save

      trip_hash = { passenger_id: passenger.id }
      # Act
      expect {
        post trips_path, params: trip_hash
      }.must_differ 'Trip.count', 1
      # Assert
      new_trip = Trip.find_by(passenger_id: passenger.id)
      must_redirect_to trip_path (new_trip.id)
    end

    it "does not create a trip if id of a passenger is invalid" do
      # Arrange
      trip_hash = {
          trip:{
              passenger_id: nil
          }
      }
      # Act
      expect {
        post trips_path, params: trip_hash
      }.must_differ 'Trip.count', 0

      # Assert
      must_respond_with :bad_request
    end
  end

  describe "edit" do
    before do
      @passenger = Passenger.create(name: "hello world")
    end
    it "responds with success when getting the edit page for an existing, valid trip" do
      # Arrange
      driver = Driver.create(
          name: "Michael Schumacher",
          vin: "QWERTY99189",
          available: true
      )
      driver.save

      passenger = Passenger.create(
          name: "Mary Poppins",
          phone_num: "2064539189"
      )
      passenger.save

      trip = Trip.create(
          driver_id: driver.id,
          passenger_id: passenger.id,
          date: "123456",
          rating: 2,
          cost: 123
      )
      trip.save

      # Act
      get edit_trip_path(id: trip.id)
      # Assert
      must_respond_with :success
    end
  end

  describe "update" do
    it "can update an existing driver with valid information accurately, and redirect" do
    # Arrange
    driver = Driver.create(
        name: "Michael Schumacher",
        vin: "QWERTY99189",
        available: true
    )
    driver.save

    passenger = Passenger.create(
        name: "Mary Poppins",
        phone_num: "2064539189"
    )
    passenger.save

    trip = Trip.create(
        driver_id: driver.id,
        passenger_id: passenger.id,
        date: "123456",
        rating: 2,
        cost: 123
    )
    trip.save

    updated_trip = {
        trip: {
            driver_id: driver.id,
            passenger_id: passenger.id,
            date: "2020/02/02",
            rating: 5,
            cost: 1979
        }
    }
    # Act
    expect {
            patch trip_path(trip.id), params: updated_trip
    }.wont_change 'Driver.count'
    # Assert
            trip_id = trip.id
            must_redirect_to trip_path
            trip = Trip.find_by(id: trip_id)
            expect(trip.driver_id).must_equal updated_trip[:trip][:driver_id].to_s
            expect(trip.passenger_id).must_equal updated_trip[:trip][:passenger_id].to_s
            expect(trip.date).must_equal updated_trip[:trip][:date]
            expect(trip.rating).must_equal updated_trip[:trip][:rating]
            expect(trip.cost).must_equal updated_trip[:trip][:cost]
    end
  end

  describe "destroy" do
    # Your tests go here
  end
end
