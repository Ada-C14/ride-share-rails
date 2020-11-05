require "test_helper"

describe TripsController do
  before do
    @driver = Driver.create(name: "Dr. Kenton Berge", vin: "12345678901234567", available: true)
    @passenger = Passenger.create(name: "Nina Hintz Sr.", phone_num: "560.815.3059")
    @trip = Trip.create(date: "2020-11-03", rating: 4, cost: 25.50, driver_id: @driver.id, passenger_id: @passenger.id )
  end

  describe "show" do
    it "responds with success when showing an existing valid trip" do
      # Act
      get trip_path(@trip.id)
      # Assert
      must_respond_with :success
    end

    it "responds with 404 with an invalid trip id" do
      # Arrange
      invalid_id = -1
      # Act
      get trip_path(invalid_id)
      # Assert
      must_respond_with :not_found
    end
  end

  describe "create" do
    # Your tests go here
    it "can create a new trip with valid information accurately, and redirect" do
      # Arrange
      # Set up the form data
      new_trip_info = {
        trip: {
        driver_id: @driver.id,
        passenger_id: @passenger.id,
        cost: 23.43,
        date: Time.now.strftime("%Y-%m-%d"),
        rating: nil
        }
      }
      # Act-Assert
      expect {
        post passenger_trips_path(@passenger), params: new_trip_info
      }.must_differ "Trip.count", 1

      # Assert
      new_trip = Trip.last
      expect(new_trip.driver_id).must_equal new_trip_info[:trip][:driver_id]
      expect(new_trip.passenger_id).must_equal new_trip_info[:trip][:passenger_id]
      expect(new_trip.date).must_equal new_trip_info[:trip][:date]
      expect(new_trip.rating).must_be_nil

      must_respond_with :redirect
      must_redirect_to passenger_path(@passenger.id)
    end

    # # not sure if we need this test, since the trip will be created internally?
    # it "does not create a trip if the form data violates Trip validations, and responds with a redirect" do
    #   # Note: This will not pass until ActiveRecord Validations lesson
    #
    #   invalid_input = {
    #     trip: {
    #       driver_id: -1,
    #       passenger_id: 5,
    #       cost: 2394,
    #       date: "2020-11-11",
    #       rating: 25
    #     }
    #   }
    #
    #   expect {
    #     post trips_path, params: invalid_input
    #   }.wont_change "Trip.count"
    #
    #   # Assert
    #   # Check that the controller redirects, render or something
    #   # todo: update after validation lesson
    #     must_respond_with :bad_request
    # end
  end

  describe "edit" do
    it "responds with success when geting the edit page for an existing, valid trip" do
      valid_id = @trip.id
      get edit_trip_path(valid_id)
      must_respond_with :success
    end

    it "responds with not_found when getting the edit page for non-existing trip" do
      invalid_id = -1
      get edit_trip_path(invalid_id)
      must_respond_with :not_found
    end
  end

  describe "update" do
    before do
      @update_info = {
        trip: {
          driver_id: @driver.id,
          passenger_id: @passenger.id,
          cost: 25.50,
          date: "2020-11-04",
          rating: 5
        }
      }
    end

    it "can update an existing trip with valid information accurately and redirect" do
      valid_id = @trip.id

      expect {
        patch trip_path(valid_id), params: @update_info
      }.wont_change "Trip.count"

      updated_trip = Trip.find(@trip.id)
      expect(updated_trip.driver_id).must_equal @update_info[:trip][:driver_id]
      expect(updated_trip.passenger_id).must_equal @update_info[:trip][:passenger_id]
      expect(updated_trip.cost).must_equal @update_info[:trip][:cost]
      expect(updated_trip.date).must_equal @update_info[:trip][:date]
      expect(updated_trip.rating).must_equal @update_info[:trip][:rating]
    end

    it "does not update any trip if given an invalid id, and respons with a 404" do
      invalid_id = -1

      expect {
        patch trip_path(invalid_id), params: @update_info
      }.wont_change "Trip.count"
    end

    it "does not update a trip if the form data violates trip validations, and responds with a redirect" do
      valid_id = @trip.id
      invalid_input = {
        trip: {
          driver_id: -1,
          passenger_id: 5,
          cost: 2394,
          date: "2020-11-11",
          rating: 25
        }
      }
      expect {
        patch trip_path(valid_id), params: invalid_input
      }.wont_change "Trip.count"

      must_respond_with :bad_request
    end
  end

  describe "destroy" do
    it "destroys the trip instance in db when trip exists, then redirects" do
      expect {
        delete trip_path(@trip)
      }.must_differ "Trip.count", -1
    end

    it "does not change the db when trip does not exist, responds with not found" do
      invalid_id = -1
      expect {
        delete trip_path(invalid_id)
      }.wont_change "Trip.count"
    end
  end
end
