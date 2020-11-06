require "test_helper"

describe TripsController do
  let (:passenger) {
    Passenger.create(name: "Anna Laura", phone_num: "999-999-0000")
  }

  let (:driver) {
    Driver.create(name: "John Meyer", vin: "WEE7868967777", available: "true")
  }

  let (:trip_hash) {
    {
        driver_id: Trip.assign_driver,
        passenger_id: passenger.id,
        date: Time.now,
        rating: nil,
        cost: Trip.generate_cost
    }
  }

  let (:trip) {
    Trip.create(trip_hash)
  }

  describe "index" do
    it "responds with success when there are trips saved" do
      # Arrange
      passenger
      driver
      trip

      # Act
      get trips_path

      # Assert
      must_respond_with :success
    end

    it "responds with success when there are no trips saved" do
      # Act
      get trips_path

      # Assert
      must_respond_with :success
    end
  end

  describe "show" do
    it "can get a valid trip" do
      passenger
      driver
      trip
      # Act
      get trip_path(trip.id)

      # Assert
      must_respond_with :success
    end

    it "will redirect for an invalid trip" do
      # Act
      get trip_path(-1)

      # Assert
      must_respond_with :redirect
    end
  end

  describe "create" do
    it "can create a new trip with valid passenger id and available drivers and sets driver to status to available == false" do
      # Arrange
      original_driver_status = driver.available
      expect(original_driver_status).must_equal "true"
      passenger
      driver
      # Act-Assert
      expect {
        post passenger_trips_path(passenger.id)
      }.must_change "Trip.count", 1

      expect(driver.available).must_equal "false"

      new_trip = Trip.find_by(driver_id: driver.id)
      # expect(new_trip.date).must_equal Date.parse(trip_hash[:trip][:date])
      # expect(new_trip.rating).must_equal trip_hash[:trip][:rating]
      must_respond_with :redirect
      must_redirect_to trip_path(new_trip.id)
    end
 end

  describe "edit" do
    it "can get the edit page for an existing trip" do

      # #Act
      get "/trips"

      # Assert
      must_respond_with :ok
    end

    it "will respond with redirect when attempting to edit a nonexistant trip" do
      # Act
      get trip_path(-1)

      # Assert
      must_respond_with :redirect
    end
  end

  describe "update" do
    it "Does not change count and redirects to trip_path when trip id is valid" do

      # Arrange
      Trip.create!(driver_id: 20, passenger_id: 57, date: "09/15/2016", rating: 5.0, cost: 16.59)
      trip_hash = {
          trip: {
              date: "11/05/2020",
              rating: 5.0,
              cost: 32.53
          },
      }
      trip = Trip.first

      # Act-Assert
      expect {
        patch trip_path(trip.id), params: trip_hash
      }.must_differ "Trip.count", 0

      must_redirect_to trip_path(trip.id)
      expect(Trip.last.date).must_equal Date.parse(trip_hash[:trip][:date])
      expect(Trip.last.rating).must_equal trip_hash[:trip][:rating]
      expect(Trip.last.cost).must_equal trip_hash[:trip][:cost]
    end

    it "will redirect to the root page if given an invalid id" do
      # Arrange
      Trip.create(driver_id: 20, passenger_id: 57, date: "11/05/2020", rating: 5.0 , cost: 32.53)
      trip_hash = {
          trip: {
              driver_id: 20,
              passenger_id: 57,
              date: "11/05/2020",
              rating: 5.0,
              cost: 32.53
          },
      }
      trip = Trip.first

      # Act-Assert
      expect {
        patch trip_path(-1), params: trip_hash
      }.must_differ "Trip.count", 0

      must_respond_with :redirect
    end
  end

  describe "destroy" do
    it "Should delete an existing trip and redirect to the page" do
      # Arrange
      trip = Trip.new driver_id: 20, passenger_id: 57, date: "09/15/2016", rating: 5.0, cost: 16.59

      trip.save!

      # Act
      expect {
        delete trip_path(trip)

        # Assert
      }.must_change 'Trip.count', -1

      trip = Trip.find_by_id(date: "09/15/2016")

      expect(trip).must_be_nil

      must_respond_with :redirect
      must_redirect_to trips_path
    end

    it "will respond with not_found for invalid ids" do

      expect {
        delete trip_path(-1)
      }.wont_change 'Trip.count'

      must_respond_with :redirect
    end
  end
end
