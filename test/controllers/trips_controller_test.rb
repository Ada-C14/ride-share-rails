require "test_helper"

describe TripsController do

  describe "show" do
    before do
      Driver.create(name: "TEST123", vin: "WBWSS52P9NEYLVDE9", available: true)
      @passenger = Passenger.create(name: "Judy", phone_num: "360-555-0987")
      @trip = Trip.create(driver_id: Driver.first.id, passenger_id: Passenger.first.id, date: "2016-04-05", rating: 3, cost: 1293)
    end
    it "can get a valid trip" do
      # Arrange
      valid_trip_id = @trip.id

      # Act
      get "/trips/#{ valid_trip_id }"

      # Assert
      must_respond_with :success
    end

    it "will redirect for an invalid trip" do
      # Arrange
      invalid_passenger_id = -1

      # Act
      get "/passengers/#{ invalid_passenger_id }"

      # Assert
      must_respond_with :not_found
    end
  end

  describe "create" do
    Driver.create(name: "TEST123", vin: "WBWSS52P9NEYLVDE9", available: true)
    available_driver = Driver.first

    let (:invalid_trip) {
      {
          trip: {
              driver_id: available_driver.id,
              date: "2016-04-05",
              rating: 5,
              cost: 12.0
          }
      }
    }

    it "can create a new trip with valid information accurately, with rating nil, turn driver's available to false, and redirect" do
      # Arrange
      @passenger = Passenger.create(name: "Judy", phone_num: "360-555-0987")
      
      # Act 
      expect {
        post passenger_trips_path(@passenger.id)
      }.must_differ 'Trip.count', 1

      # Check the rating for new trip is nil and driver available becomes false
      trip = @passenger.trips.last
      expect(trip.rating).must_be_nil
      expect(trip.driver.available).must_equal false

      # Check that the controller redirected the user
      must_respond_with :redirect
      must_redirect_to passenger_path(@passenger.id)
    end


    it "does not create a trip if no driver is available" do
      # Arrange
      @passenger = Passenger.create(name: "Judy", phone_num: "360-555-0987")
      available_driver.update(available: false)
      Driver.all.update(available: false)

      # Act
      expect {
        post passenger_trips_path(@passenger.id)  
      }.wont_change 'Trip.count'

      # Assert
      must_redirect_to passenger_path(@passenger.id)
    end

    it "does not create a trip for non-existing passenger" do
      passenger_id = -1

      expect {
        post passenger_trips_path(passenger_id)
      }.wont_change 'Trip.count'

      must_respond_with :not_found
    end
  end

  describe "edit" do
    before do
      Driver.create(name: "TEST123", vin: "WBWSS52P9NEYLVDE9", available: true)
      @passenger = Passenger.create(name: "Judy", phone_num: "360-555-0987")
      @trip = Trip.create(driver_id: Driver.first.id, passenger_id: Passenger.first.id, date: "2016-04-05", rating: 3, cost: 1293)
    end
    it "responds with success when getting the edit page for an existing, valid trip" do
      # Arrange & Act
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
      Driver.create(name: "TEST123", vin: "WBWSS52P9NEYLVDE9", available: true)
      @passenger = Passenger.create(name: "Judy", phone_num: "360-555-0987")
      @trip = Trip.create(driver_id: Driver.first.id, passenger_id: Passenger.first.id, date: "2016-04-05", rating: 3, cost: 1293)
    end
    let (:valid_trip) { 
      { 
          trip: {
          date: "2016-04-05", 
          rating: 5, 
          cost: 12.0
        }
      }    
    }

    let (:invalid_trip) {
      {
          trip: {
              date: "2016-04-05",
              rating: 50,
              cost: 12.0
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
      expect(update_trip.driver_id).must_equal @trip.driver_id
      expect(update_trip.passenger_id).must_equal @trip.passenger_id
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
        patch trip_path(id), params: valid_trip
      }.wont_change 'Trip.count'

      # Assert
      must_respond_with :not_found
    end

    it "does not update a trip if the form data violates rating, and responds with a redirect" do
      # Arrange
      id = @trip.id

      # Act-Assert
      expect {
        patch trip_path(id), params: invalid_trip
      }.wont_change 'Trip.count'

      # Assert
      must_respond_with :bad_request
    end
  end

  describe "destroy" do
    before do
      @driver = Driver.create(name: "TEST123", vin: "WBWSS52P9NEYLVDE9", available: true, isactive: true)
      @passenger = Passenger.create(name: "Judy", phone_num: "360-555-0987")
      @trip = Trip.create(driver_id: @driver.id, passenger_id: @passenger.id, date: "2016-04-05", rating: 3, cost: 1293)
    end

    it "can delete the trip instance in db when trip exists and both driver and passenger are inactive, then redirects" do
      # Arrange
      valid_trip = @trip.id
      # inactive driver & passenger
      @driver.update(available: false, isactive: false)
      @passenger.update(isactive: false)
      
      # Act-Assert
      expect {
        delete trip_path(valid_trip)
      }.must_change "Trip.count", 1
      
      expect(@driver.isactive).must_equal false
      expect(@passenger.isactive).must_equal false

      # Assert
      must_redirect_to root_path
    end

    it "does not change the db when the trip does not exist, then responds with 404" do
      # Arrange
      id = -1

      # Act-Assert
      expect {
        delete trip_path(id)
      }.wont_change "Trip.count"

      # Assert
      must_respond_with :not_found
    end

    it "does not change the db when trip exists but either driver and passenger are still active, then redirects" do
      # Arrange
      valid_trip = @trip.id
      # inactive driver & passenger
      @driver.update(available: false, isactive: false)

      # Act-Assert
      expect {
        delete trip_path(valid_trip)
      }.wont_change "Trip.count"
      
      expect(@driver.isactive).must_equal false
      expect(@passenger.isactive).must_equal true

      # Assert
      must_redirect_to trip_path(@trip.id)
    end
  end

  describe "complete_trip" do
    it "updates trip complete status and driver available status" do
      @driver_1 = Driver.create(name: "TEST123", vin: "WBWSS52P9NEYLVDE9", available: true, isactive: true)
      @passenger_1 = Passenger.create(name: "Judy", phone_num: "360-555-0987")
      @trip_1 = Trip.create(driver_id: @driver_1.id, passenger_id: @passenger_1.id, date: "2016-04-05", rating: 3, cost: 1293, complete: false)

      expect {
        patch complete_trip_path(@trip_1.id)
      }.wont_change 'Trip.count'

      expect(Driver.find_by(id: @driver_1.id).available).must_equal true
      expect(Trip.find_by(id: @trip_1.id).complete).must_equal true

      must_redirect_to trip_path(@trip_1.id)
    end
  end
end
