require "test_helper"

describe TripsController do
  describe "show" do
    before do
      @trip = Trip.create(date: "test1", rating: "test2", cost: "test3")
    end

    it "responds with success when showing an existing valid trip" do
      # Arrange
      valid_trip_id = @trip.id

      # Act
      get "/trips/#{valid_trip_id}"
      # Assert
      must_respond_with :success
    end

    it "responds with redirect with an invalid trip id" do
      # Arrange
      invalid_trip_id = -1
      # Ensure that there is an id that points to no trip

      # Act
      get "/trips/#{invalid_trip_id}"

      # Assert
      must_respond_with :redirect
    end
  end

  describe "create" do
    it "can create a new trip with valid information accurately, and redirect" do
      # Arrange
      trip_hash = {
          trip: {
              date: "test1",
              rating: 3,
              cost: 10.0
          }
      }
      # Act-Assert
      expect {
        post trips_path, params: trip_hash
      }.must_change "Trip.count", 1
      # Assert
      new_trip = Trip.find_by(date: trip_hash[:trip][:date])
      expect(new_trip.rating).must_equal trip_hash[:trip][:rating]
      expect(new_trip.cost).must_equal trip_hash[:trip][:cost]

      must_respond_with :redirect
      must_redirect_to trip_path(new_trip.id)
    end

    it "does not create a trip if the form data violates trip validations, and responds with a redirect" do
      trip_hash = {
          trip: {
              date: "test1",
              rating: 5,
              cost: 10
          }
      }
      expect {
        post trips_path, params: trip_hash
      }.wont_change "trip.count"

      must_respond_with :bad_request


    end
  end

  describe "edit" do

    before do
      Trip.create(date: "test1", rating: "test2", cost: "test3")
    end
    it "responds with success when getting the edit page for an existing, valid Trip" do
      # Arrange
      id = Trip.first.id
      get edit_Trip_path(id)

      # Act

      # Assert
      must_respond_with :success
    end

    it "responds with redirect when getting the edit page for a non-existing Trip" do
      # Arrange
      get edit_Trip_path(-1)

      # Act

      # Assert
      must_respond_with :redirect

    end
  end

  describe "update" do

    before do
      Trip.create(date: "test1", rating: "test2", cost: "test3")
    end
    let (:new_Trip_hash){
      {
          Trip:{
              date:"testA",
              rating:"testB",
              cost: "testC"
          },
      }
    }
    it "can update an existing Trip with valid information accurately, and redirect" do
      # Arrange
      id = Trip.first.id
      expect {
        patch Trip_path(id), params: new_Trip_hash
      }.wont_change "Trip.count"

      # Act-Assert
      must_respond_with :redirect

      # Assert
      trip = Trip.find_by(date: trip_hash[:trip][:date])
      expect(trip.rating).must_equal trip_hash[:trip][:rating]
      expect(trip.cost).must_equal trip_hash[:trip][:cost]

    end

    it "does not update any Trip if given an invalid id, and responds with a 404" do
      # Arrange
      id = -1
      expect{
        patch Trip_path(id), params: new_Trip_hash
      }.wont_change "Trip.count"

      # Act-Assert
      must_respond_with :not_found

      # Assert
      # Check that the controller gave back a 404

    end

    it "does not edit a Trip if the form data violates Trip validations, and responds with a redirect" do

      id = Trip.first.id
      invalid_Trip_hash = {
          Trip:{
              date:"testAB",
              rating:"testCD",
              cost: "testEF"
          },
      }
      expect {
        patch Trip_path(id), params: invalid_Trip_hash
      }.wont_change "Trip.count"

      must_respond_with :bad_request

      Trip = Trip.find_by(id: id)
      expect(Trip.date).must_equal "testing"
      expect(Trip.rating).must_equal "testing"
      expect(Trip.cost).must_equal "testing"
    end
  end

  describe "destroy" do
    it "destroys the trip instance in db when trip exists, then redirects" do
      # Arrange
      trip = trip.create(date: "test1", rating: "test2", cost: "test3")

      # Act-Assert
      expect {
        delete trip_path(trip.id)
      }.must_change "trip.count", -1

      # Assert
      must_respond_with :redirect

    end

    it "does not change the db when the trip does not exist, then responds with 404" do
      expect {
        delete trip_path(-1)
      }.wont_change "trip.count"
      must_respond_with :not_found
    end

  end
end
