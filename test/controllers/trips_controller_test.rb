require "test_helper"

describe TripsController do
  before do
    @driver = Driver.create(name: "Jared", vin: "ABC1234")
    @passenger = Passenger.create(name: "Li", phone_num: "1112223333")

    @trip = Trip.create(date: Date.today, passenger_id: @passenger.id, driver_id: @driver.id, rating: nil, cost: 10)
  end

  describe "show" do
    it "responds with success when showing an existing valid trip" do
      id = @trip.id
      get trip_path(id)

      must_respond_with :success
    end

    it "responds with redirect with an invalid trip id" do
      get trip_path(-1)

      must_respond_with :redirect
    end
  end

  describe "create" do
    it "can create a new trip with valid information accurately, and redirect" do

      driver = Driver.create(name: "Li", vin: "ABC1234")
      passenger = Passenger.create(name: "Jared", phone_num: "1112223333")

      new_trip = {
          trip: {
              date: Date.today,
              passenger_id: passenger.id,
              driver_id: driver.id,
              rating: nil,
          }
      }

      expect {
        post passenger_trips_path(passenger.id), params: new_trip
      }.must_differ "Trip.count", 1

      must_respond_with :redirect
      # must_redirect_to trip_path(new_trip.id)
      expect(Trip.last.passenger.name).must_equal passenger.name
      expect(Trip.last.driver.name).must_equal driver.name
    end

    it "does not create a trip if the form data violates trip validations, and responds with a redirect" do

      new_trip = {
          trip: {
          }
      }

      expect {
        post passenger_trips_path(50), params: new_trip
      }.wont_change "Trip.count"

      must_respond_with :redirect
    end
  end


  describe "edit" do

    it "responds with success when getting the edit page for an existing, valid Trip" do
      id = @trip.id

      get edit_trip_path(id)

      must_respond_with :success
    end

    it "responds with redirect when getting the edit page for a non-existing Trip" do
      id = -1

      get edit_trip_path(id)

      must_respond_with :redirect
    end
  end

  describe "update" do

    let (:trip_update) {
      {
          trip: {
              rating: 5
          }
      }
    }
    it "can update an existing Trip with valid information accurately, and redirect" do

      id = @trip.id

      expect {
        patch trip_path(id), params: trip_update
      }.wont_change "Trip.count"

      must_redirect_to trip_path(id)

      test_trip = Trip.find_by(id: id)
      expect(test_trip.rating).must_equal trip_update[:trip][:rating]

    end

    it "does not update any Trip if given an invalid id, and responds with a redirect" do
      id = -1

      expect {
        patch trip_path(id), params: trip_update
      }.wont_change "Trip.count"

      must_respond_with :redirect
    end
  end

  describe "destroy" do
    it "destroys the trip instance in db when trip exists, then redirects" do

      id = @trip.id
      passenger_id = @passenger.id

      expect {
        delete trip_path(id)
      }.must_change "Trip.count", -1

      must_redirect_to passenger_path(id: passenger_id)
    end

    it"does not change the db when the trip does not exist, then responds with redirect" do
      id = -1

      expect {
        delete trip_path(id)
      }.wont_change "Trip.count"

      must_respond_with :redirect
    end
  end
end