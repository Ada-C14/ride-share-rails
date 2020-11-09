require "test_helper"

describe TripsController do
  before do
    @driver = Driver.create!(name: "Test Driver", vin: "123456", available: true)
    @passenger = Passenger.create!(name: "Test passenger", phone_num: 1232)
    @trip = Trip.create!(driver_id: @driver.id, passenger_id: @passenger.id, date: Time.now, rating: nil, cost: rand(1..1000))
  end

  describe "show" do
    it "responds with success when showing an existing valid trip" do
      # Act
      get trip_path(@trip.id)
      # Assert
      must_respond_with :success
    end

    it "redirects for an invalid trip id" do
      # Arrange
      bad_id = -9999

      # Act
      get trip_path(bad_id)

      # Assert
      must_redirect_to root_path
    end

  end

  describe "new" do
    it "responds with success" do
      get new_trip_path
      must_respond_with :success
    end
  end

  describe "create" do
    it "can create a new trip with valid information accurately, and redirect" do
      # Arrange
    #need a passenger
    Trip.destroy_all
    
    new_passenger = Passenger.create!(name: "Test passenger", phone_num: 1232)
      expect {
        post passenger_trips_path(new_passenger)
      }.must_differ 'Trip.count', 1

      new_passenger.reload #
      new_trip = new_passenger.trips.order(:created_at) # sorting the trip list 
      new_trip = new_trip.first
      expect(new_trip.driver.id).must_equal @driver.id

      must_respond_with :redirect
      must_redirect_to trip_path(new_trip.id)

    end

    it "does not create a trip if violate Validation rules-missing driver_id" do
       # Arrange
       trip_hash = {
        trip: {
        passenger_id: @passenger.id,
        date: Time.now,
        rating: nil,
        cost: rand(1..1000)
        }
      }

      # Act-Assert
      # Ensure that there is no change in trip.count
      expect {
        post trips_path, params: trip_hash
      }.wont_change 'Trip.count'

      # Assert
      must_redirect_to root_path
    end

  end
  
  describe "edit" do
    it "responds with success when getting the edit page for an existing, valid trip" do
      get edit_trip_path(@trip.id)
      must_respond_with :success
    end

    it "responds with redirect when getting the edit page for a non-existing trip" do
      get trip_path(-1)

      must_respond_with :redirect
      must_redirect_to root_path
    end
  end

  describe "update" do
    let (:new_trip_hash) {
      {
        trip: {
          driver_id: @driver.id,
          passenger_id: @passenger.id,
          date: Time.now,
          rating: nil,
          cost: rand(1..1000)
        }
      }
    }
    it "can update an existing trip with valid information accurately, and redirect" do
      # Act-Assert
      # Ensure that there is no change in trip.count
      expect {
        patch trip_path(@trip.id), params: new_trip_hash # the params method set the data structure 
        }.wont_change 'Trip.count'
      
      # Assert
      trip = Trip.find_by(id: @trip.id)
      expect(trip.driver_id).must_equal new_trip_hash[:trip][:driver_id]
      expect(trip.passenger_id).must_equal new_trip_hash[:trip][:passenger_id]

      must_respond_with :redirect
      must_redirect_to root_path
    end

    it "does not update any trip if given an invalid id, and responds with a redirect" do
      # Arrange
      patch trip_path(-1)

      # Act-Assert
      expect {
        patch trip_path(-1), params: new_trip_hash # the params method set the data structure 
        }.wont_change 'Trip.count'
      # Ensure that there is no change in trip.count

      # Assert
      must_respond_with :redirect
      must_redirect_to trips_path
    end

    it "does not update a trip if the form data violates trip validations, and responds with a sucess" do
       # Arrange
       trip_hash = {
        trip: {
          passenger_id: @passenger.id,
          date: Time.now,
          rating: nil,
          cost: rand(1..1000)
        }
      }

      # Act-Assert
      expect {
        patch trip_path(id: @trip.id), params: trip_hash
      }.wont_change 'Trip.count'

      # Ensure that there is no change in trip.count

      # Assert
      must_redirect_to root_path
    end
  end

  describe "destroy" do
    it "destroys the trip instance in db when trip exists, then redirects" do
      expect {
        delete trip_path(@trip.id)

      # Assert
      }.must_change 'Trip.count', -1
    
      trip = Trip.find_by(id: @trip.id)

      expect(trip).must_be_nil

      must_respond_with :redirect
      must_redirect_to root_path
    end

    it "does not change the db when the trip does not exist, then responds with redirect " do
      expect {
        delete trip_path(-1)
      }.wont_change 'Trip.count'

      must_respond_with :redirect
      must_redirect_to root_path
    end
  end
end

