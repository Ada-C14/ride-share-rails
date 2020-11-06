require "test_helper"

describe TripsController do
  before do
    Passenger.create(name: "Test", phone_num: "123-123-1234")
    Driver.create(name: "Peach", vin:"123456789", available:true )
    @trip = Trip.create(driver_id: Driver.first.id, passenger_id: Passenger.first.id, date: Date.today, rating:  4, cost: 1324)
  end

  describe "show" do

    it "will get show for valid trip id" do
      get "/trips/#{@trip.id}"

      must_respond_with :success
    end

    it "will respond with not_found for invalid ids" do
      get "/trips/-1"

      must_respond_with :not_found
    end
  end

  describe "new" do

    it "will get new_passenger_path" do
      get new_trip_path
      must_respond_with :success
    end

  end

  describe "create" do
    before do
      Driver.create(name: "Pear", vin:"987654321", available:true )
    end

    let (:trip_hash) {
      {trip:{
          driver_id: 2,
          passenger_id: 2
      }}
    }

    # it "can create a new trip" do
    #   get new_trip_path(1)
    #   expect{
    #     post trips_path
    #   }.wont_change "Trip.count", 1
    #
    #
    # end
    #
    it "will not create a trip with invalid params" do
      trip_hash[:trip][:driver_id] = nil

      expect{
        post trips_path, params: trip_hash
      }.wont_change "Trip.count"

      must_respond_with :bad_request
    end
  end

  describe "edit" do
    it "will get edit_trip_path" do
      get edit_trip_path(@trip.id)
      must_respond_with :success
    end

    it "will respond with not_found with invalid ids" do
      get edit_trip_path(-1)
      must_respond_with :not_found
    end
  end

  describe "update" do
    before do
      Passenger.create(name: "Banana", phone_num: "123-123-1230")
      Driver.create(name: "Berry", vin:"123456780", available:true )

    end

    let (:trip_hash) {
      {trip:{
          driver_id: Driver.last.id,
          passenger_id: Passenger.last.id,
          date: Date.today,
          rating: 3,
          cost: 4321
      }}
    }

    it "will update trip info with valid input" do
      id = Trip.first.id
      expect {
        patch trip_path(id), params: trip_hash
      }.wont_change "Trip.count"

      must_respond_with :redirect
    end

    it "will not update if the params are invalid" do
      trip_hash[:trip][:driver_id] = nil

      expect {
        patch trip_path(@trip.id), params: trip_hash
      }.must_differ "Passenger.count", 0

      must_respond_with :bad_request

      @trip.reload
      expect(@trip.driver_id).wont_be_nil

    end
  end

  describe "destroy" do
    it "will delete a trip" do
      expect{
        delete trip_path(@trip.id)
      }.must_change 'Trip.count', 1

      must_respond_with :redirect
      must_redirect_to trips_path
    end

    it "will respond with not_found with invalid ids" do
      expect{
        delete trip_path(-1)
      }.wont_change 'Trip.count'

      must_respond_with :not_found
    end
  end
end
