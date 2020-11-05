require "test_helper"

describe TripsController do
  describe "show" do
    it "can get a valid trip" do
      # Your tests go here
    end

    it "will redirect for an invalid trip" do
      # Your tests go here
    end
  end

  describe "create" do
    # Your tests go here
  end

  describe "edit" do
    before do
      @trip = Trip.create(driver_id: 1, passenger_id: 2, date: "2016-04-05", rating: 3, cost: 1293)
    end

    it "responds with success when getting the edit page for an existing, valid trip" do
      # Arrange & Actgit add
      get edit_trip_path(@trip.id)

      # Assert
      must_respond_with :success
    end

    it "responds with redirect when getting the edit page for a non-existing trip" do
      # Arrange
      # Act
      get edit_trip_path(-1)

      # Assert
      must_respond_with :not_found
    end
  end

  describe "update" do
    before do
      @trip = Trip.create(driver_id: 1, passenger_id: 2, date: "2016-04-05", rating: 3, cost: 1293)
    end

    let (:valid_trip) { 
      { 
        driver: {
          driver_id: 1, 
          passenger_id: 2, 
          date: "2016-04-05", 
          rating: 5, 
          cost: 12
        }
      }    
    }
    it "can update an existing trip with valid information accurately, and redirect" do
      # Arrange
      id = @trip.id

      # Act-Assert
      expect {
        patch trip_path(id), params: valid_trip
      }.wont_change 'Trip.count'

      # Assert
      update_trip = Trip.find_by(id: id)
      expect(update_trip.driver_id).must_equal valid_trip[:trip][:driver_id]
      expect(update_trip.passenger_id).must_equal valid_trip[:trip][:passenger_id]
      expect(update_trip.date).must_equal valid_trip[:trip][:date]
      expect(update_trip.rating).must_equal valid_trip[:trip][:rating]
      expect(update_trip.cost).must_equal valid_trip[:trip][:cost]

      # Check that the controller redirected the user
      must_redirect_to trip_path(id)
    end

    it "does not update any driver if given an invalid id, and responds with a 404" do
      # Arrange
      id = -1

      # Act-Assert
      expect {
        patch trip_path(id), params: trip_driver
      }.wont_change 'Trip.count'

      # Assert
      must_respond_with :not_found
    end

    it "does not create a trip if the form data violates Driver/Passenger validations, and responds with a redirect" do
      # Note: This will not pass until ActiveRecord Validations lesson
      # Arrange
      # Ensure there is an existing driver saved
      # Assign the existing driver's id to a local variable
      # Set up the form data so that it violates Driver validations

      # Act-Assert
      # Ensure that there is no change in Driver.count

      # Assert
      # Check that the controller redirects

    end

  end

  describe "destroy" do
    it "destroys the trip instance in db when trip exists, then redirects" do
      # Arrange
      # Ensure there is an existing driver saved

      # Act-Assert
      # Ensure that there is a change of -1 in Driver.count

      # Assert
      # Check that the controller redirects

    end

    it "does not change the db when the trip does not exist, then responds with " do
      # Arrange
      id = -1

      # Act-Assert
      expect {
        delete trip_path(id)
      }.wont_change "Trip.count"

      # Assert
      must_respond_with :not_found
    end
  end
end
