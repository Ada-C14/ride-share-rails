require "test_helper"

describe TripsController do

  let (:trip) do
    driver = Driver.create(name: "Test Trip Driver", vin: "HKJS12345HJGS", availability_status: true)
    passenger = Passenger.create(name: "Anna Bobby", phone_number: "BFJHD2345654")
    Trip.create(
        rating: 1,
        cost: 4.99,
        date: Time.now - 4.days,
        driver_id: driver.id,
        passenger_id: passenger.id
    )
  end

  describe "show" do
    it "responds with success when showing an existing valid trip" do
      # Arrange
      # Ensure that there is a trip saved
      t = trip
      # Act
      get trip_path(t.id)
      # Assert
      must_respond_with :success

    end

    it "responds with 404 with an invalid trip id" do
      # Arrange
      # Ensure that there is an id that points to no trip

      # Act
      get trip_path(-1)
      # Assert
      must_respond_with :not_found
    end
  end

  describe "create" do

    it "can create a new trip with valid information accurately, and redirect" do
      # Arrange
      # Set up the form data

      driver = Driver.create(name: "Test Trip Driver", vin: "HKJS12345HJGS", availability_status: true)
      passenger = Passenger.create(name: "Anna Bobby", phone_number: "BFJHD2345654")
      trip_hash = {
        trip: {
          rating: 5,
          cost: 12.32,
          date: Time.now,
          driver_id: driver.id,
          passenger_id: passenger.id
        }
      }

      # Act-Assert
      # Ensure that there is a change of 1 in trip.count
      expect {
        post trips_path, params: trip_hash
      }. must_differ "Trip.count", 1


      # Assert
      # Find the newly created trip, and check that all its attributes match what was given in the form data
      # Check that the controller redirected the user
      new_trip = Trip.last

      expect(new_trip.rating).must_equal trip_hash[:trip][:rating]
      expect(new_trip.cost).must_equal trip_hash[:trip][:cost]
      expect(new_trip.date).must_equal trip_hash[:trip][:date].to_date
      expect(new_trip.driver_id).must_equal trip_hash[:trip][:driver_id]
      expect(new_trip.passenger_id).must_equal trip_hash[:trip][:passenger_id]

      must_respond_with :redirect
      must_redirect_to trip_path(new_trip.id)
    end

    it "does not create a trip if the form data violates trip validations, and responds with a redirect" do
      # Note: This will not pass until ActiveRecord Validations lesson
      # Arrange
      #  Set up the form data so that it violates trip validations
      driver = Driver.create(name: "Test Trip Driver", vin: "HKJS12345HJGS", availability_status: true)
      passenger = Passenger.create(name: "Anna Bobby", phone_number: "BFJHD2345654")

      invalid_trip_hash1 = {
        trip: {
          rating: 5,
          cost: 12.32,
          driver_id: driver.id,
          passenger_id: passenger.id
        }
      }

      invalid_trip_hash2 = {
        trip: {
          rating: 5,
          date: Time.now,
          driver_id: driver.id,
          passenger_id: passenger.id
        }
      }

      # Act-Assert
      # Ensure that there is no change in trip.count

      expect{
        post trips_path, params: invalid_trip_hash1
      }.wont_change "Trip.count"

      expect{
        post trips_path, params: invalid_trip_hash2
      }.wont_change "Trip.count"

      # Assert
      # Check that the controller redirects
      must_redirect_to root_path
    end

    #TODO: Add a test to check for trip creation from nested route?
  end

  before do
    driver = Driver.create(name: "Test Trip Driver", vin: "HKJS12345HJGS", availability_status: true)
    passenger = Passenger.create(name: "Anna Bobby", phone_number: "BFJHD2345654")

    @trip = Trip.create(
      rating: 1,
      cost: 20.46,
      date: Time.now,
      driver_id: driver.id,
      passenger_id: passenger.id
    )
  end

  let(:new_trip) {
    driver = Driver.create(name: "New Test Trip Driver", vin: "HKJS12345HJGS", availability_status: true)
    passenger = Passenger.create(name: "New Anna Bobby", phone_number: "BFJHD2345654")
    {
      trip: {
        rating: 5,
        cost: 12.32,
        date: Time.now,
        driver_id: driver.id,
        passenger_id: passenger.id
      }
    }
  }

  describe "edit" do
    it "responds with success and redirect when getting the edit page for an existing, valid trip" do
      # Arrange
      # Ensure there is an existing trip saved
      found_trip = Trip.find_by(id: @trip.id)
      # Act
      get edit_trip_path(trip.id)
      # Assert
      must_respond_with :success
    end

    it "responds with redirect when getting the edit page for a non-existing trip" do
      # Arrange
      # Ensure there is an invalid id that points to no trip

      # Act
      get edit_trip_path(-1)
      # Assert
      must_respond_with :not_found

    end
  end

  describe "update" do
    it "can update an existing trip with valid information accurately, and redirect" do
      # Arrange
      # Ensure there is an existing trip saved
      # Assign the existing trip's id to a local variable
      # Set up the form data

      found_trip = Trip.find_by(id: @trip.id)

      # Act-Assert
      # Ensure that there is no change in trip.count

      expect{
        patch trip_path(found_trip.id), params: new_trip
      }. wont_change "Trip.count"

      must_redirect_to trip_path(found_trip.id)

      # Assert
      # Use the local variable of an existing trip's id to find the trip again, and check that its attributes are updated
      # Check that the controller redirected the user

      found_trip.reload
      expect(found_trip.cost).must_equal new_trip[:trip][:cost]
      expect(found_trip.rating).must_equal new_trip[:trip][:rating]
      expect(found_trip.date).must_equal new_trip[:trip][:date].to_date
      expect(found_trip.driver_id).must_equal new_trip[:trip][:driver_id]
      expect(found_trip.passenger_id).must_equal new_trip[:trip][:passenger_id]

    end

    it "does not update any trip if given an invalid id, and responds with a 404" do
      # Arrange
      # Ensure there is an invalid id that points to no trip
      # Set up the form data

      # Act-Assert
      # Ensure that there is no change in trip.count
      expect{
        patch trip_path(-1), params: new_trip
      }. wont_change "Trip.count"

      # Assert
      # Check that the controller gave back a 404
      must_respond_with :not_found
    end

    it "does not create a trip if the form data violates trip validations, and responds with a redirect" do
      # Note: This will not pass until ActiveRecord Validations lesson
      # Arrange
      # Ensure there is an existing trip saved
      # Assign the existing trip's id to a local variable

      found_trip = Trip.find_by(id: @trip.id)

      # Set up the form data so that it violates trip validations
      driver = Driver.create(name: "New Test Trip Driver", vin: "HKJS12345HJGS", availability_status: true)
      passenger = Passenger.create(name: "New Anna Bobby", phone_number: "BFJHD2345654")
      invalid_trip_hash1 = {
          trip: {
              rating: 5,
              cost: 12.32,
              driver_id: driver.id,
              passenger_id: passenger.id
          }
      }

      invalid_trip_hash2 = {
          trip: {
              rating: 5,
              date: Time.now,
              driver_id: driver.id,
              passenger_id: passenger.id
          }
      }

      # Act-Assert
      # Ensure that there is no change in trip.count

      expect{
        patch trip_path(found_trip.id), params: invalid_trip_hash1
      }.wont_change "Trip.count"

      expect{
        patch trip_path(found_trip.id), params: invalid_trip_hash2
      }.wont_change "Trip.count"

      # Assert
      # Check that the controller redirect
      must_respond_with :redirect
      must_redirect_to trip_path(found_trip.id)

      #check to make sure attempted save with invalid params did not overwrite previously saved object
      #
      refound_trip = Trip.find_by(id: @trip.id)
      expect(refound_trip).must_equal found_trip
    end
  end

  describe "destroy" do
    it "destroys the trip instance in db when trip exists, then redirects" do
      # Arrange
      # Ensure there is an existing trip saved
      trip_to_delete = Trip.find_by(id: @trip.id)
      # Act-Assert
      # Ensure that there is a change of -1 in trip.count
      expect {
        delete trip_path(trip_to_delete.id)
      }.must_differ "Trip.count", -1
      # Assert
      # Check that the controller redirects

      trip_to_delete = Trip.find_by(id: @trip.id)

      expect(trip_to_delete).must_be_nil

      must_redirect_to trips_path

    end

    it "does not change the db when the trip does not exist, then responds with " do
      # Arrange
      # Ensure there is an invalid id that points to no trip

      # Act-Assert
      # Ensure that there is no change in trip.count
      expect{
        delete trip_path(-1)
      }.wont_change "Trip.count"
      # Assert
      # Check that the controller responds or redirects with whatever your group decides

      must_respond_with :not_found
    end
  end

end
