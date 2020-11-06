require "test_helper"

describe TripsController do

  describe "show" do
    # Your tests go here

    it "responds with success when showing an existing valid trip" do
      # Arrange
      test_driver = Driver.create(name: "test driver", vin: "ABCDE", available: true)

      new_trip = Trip.create(
          date: Time.now,
          cost: 100,
          passenger_id: 2,
          driver_id: test_driver.id,
          rating: nil
      )

      # Ensure that there is a trip saved
      # Act
      get trip_path(id: [Trip.find_by(id: new_trip.id)] )
      # Assert
      must_respond_with :success

    end

    it "must respond with not found for a non-existing trip" do
      # Ensure that there is an id that points to no trip
      # Act
      get trip_path(-1)
      # Assert
      must_respond_with :not_found
    end
  end

  describe "create" do
    # Your tests go here

    it "can create a new trip for a given passenger  with a random driver" do
      test_driver = Driver.create(name: "test driver", vin: "ABCDE", available: true)
      test_passenger = Passenger.create!(name: "test passenger", phone_num: "111-111-1111")
      trip_hash = {
          passenger_id: test_passenger.id
      }



      expect {
        post trips_path, params: trip_hash
      }.must_change "Trip.count", 1

      new_trip = Trip.find_by(driver_id: test_driver.id)
      # expect(new_trip.rating).must_equal trip_hash[:trip][:rating]
      # expect(new_trip.cost).must_equal trip_hash[:trip][:cost]

      must_respond_with :redirect
      must_redirect_to trip_path(id: new_trip.id)
    end

  end

  describe "edit" do
    # Your tests go here

    it "can get the edit page for an existing trip" do
      test_driver = Driver.create(name: "test driver", vin: "ABCDE", available: true)
      new_trip = Trip.create(
          date: Time.now,
          cost: 100,
          passenger_id: 2,
          driver_id: test_driver.id,
          rating: nil
      )
      get edit_trip_path(id: [Trip.find_by(id: new_trip.id)])

      must_respond_with :not_found
    end

    it "will respond with redirect when attempting to edit a nonexistant trip" do
      get edit_trip_path(-1)

      must_respond_with :not_found
    end
  end

  describe "update" do
    # Your tests go here
    it "can update an existing trip" do

    driver = Driver.create!(name: "CAT", vin: "ABC", available: true)
    passenger = Passenger.create!(name: "CAT", phone_num: "111-111-1111")

    # updated_driver = Driver.create(name: "DOG", vin: "DEF")
    existing_trip = Trip.create!(
        driver_id: driver.id,
        passenger_id: passenger.id,
        date: DateTime.now,
        rating: 5,
        cost: 100
    )

    update_info = {
        trip: {
            rating: 3,
            # driver_id: updated_driver.id
        }
    }

      patch trip_path(id: existing_trip.id), params: update_info

      updated_trip = Trip.find_by(id: existing_trip.id)
      expect(updated_trip.rating).must_equal update_info[:trip][:rating]
      # expect(updated_trip.driver_id).must_equal update_info[:trip][:driver_id]

      must_respond_with :redirect
      must_redirect_to trip_path(id: [Trip.find_by(id: existing_trip.id)])
    end

    it "will redirect to not found if given an invalid id" do
      patch driver_path(-1)

      must_respond_with :redirect
    end
  end

  describe "destroy" do
    # Your tests go here
    driver = Driver.create(name: "Test", vin: "ABC", available: true)
    trip = Trip.create(driver_id: driver.id, passenger_id: 123, date: DateTime.now, rating: 3, cost: 100)

    it "deletes an existing trip successfully" do
      expect {
        delete trips_path( id: [Trip.find_by(id: trip.id)] )
      }.must_differ "Trip.count", -1

      must_redirect_to homepages_path

      # must_redirect_to passenger_path(id: trip.passenger_id)
      # must_redirect_to driver_path(id: driver.passenger_id)

    end

    it "redirects if trip is not available to delete" do
      expect {
        delete trip_path( -1 )
      }.must_differ "Trip.count", 0

      must_redirect_to root_path

    end
  end
end


