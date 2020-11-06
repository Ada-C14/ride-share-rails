require "test_helper"

describe TripsController do


  let(:trip){
    Trip.create!(date: Date.current, cost: 7777, passenger: Passenger.create(name: "sample passenger", phone_num: "999-999-9999"), driver: Driver.create(name: "Kari", vin: "WBWSS52P9NEYLVDE9", available: true))
  }

  let(:passenger){
    Passenger.create name: "sample passenger", phone_num: "999-999-9999"
  }

  describe "show" do

    it "can get a valid trip" do
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
    # Your tests go here
    it "can create a new trip" do

      Driver.create name: "Bernardo Prosacco", vin: "WBWSS52P9NEYLVDE9", available: true

      expect{
        post passenger_trips_path(passenger.id)
      }.must_change "Trip.count", 1

    end
  end

  describe "edit" do
    it "can get the edit page for an existing trip" do
      get edit_trip_path(trip.id)

      must_respond_with :success
    end

    it "will respond with redirect when attempting to edit a nonexistant trip" do
      get edit_trip_path(-1)

      must_respond_with :redirect
    end
  end

  describe "update" do

    before do
      Trip.create!(date: Date.current, cost: 7777, passenger: Passenger.create(name: "sample passenger", phone_num: "999-999-9999"), driver: Driver.create(name: "Kari", vin: "WBWSS52P9NEYLVDE9", available: true))
    end

    let (:edit_trip_hash) do
      {
          trip: {
              date: Date.tomorrow,
              rating: 1,
              cost: 777
          }
      }
    end

    it "can update an existing trip" do
      id = Trip.first.id
      expect{
        patch trip_path(id), params: edit_trip_hash
      }.wont_change "Trip.count"

      must_respond_with :redirect

      new_trip = Trip.find_by(id: id)
      expect(new_trip.date).must_equal edit_trip_hash[:trip][:date]
      expect(new_trip.rating).must_equal edit_trip_hash[:trip][:rating]
      expect(new_trip.cost).must_equal edit_trip_hash[:trip][:cost]
    end

    it "will redirect to the root page if given an invalid id" do
      id = -1
      patch trip_path(id), params: edit_trip_hash
      must_redirect_to trips_path
    end
  end

  describe "destroy" do
    before do
      Trip.create!(cost: 7777, date: Date.current, passenger: Passenger.create(name: "sample passenger", phone_num: "999-999-9999"), driver: Driver.create(name: "Kari", vin: "WBWSS52P9NEYLVDE9", available: true))
    end

    # Your tests go here
    it "can destroy a trip" do
      # Arrange
      id = Trip.first.id

      # Act
      expect{
        delete trip_path(id)
      }.must_change 'Trip.count', -1

      empty_trip = Trip.find_by(date: Date.current)

      expect(empty_trip).must_be_nil

      must_respond_with :redirect
      must_redirect_to trips_path
    end

    it "will redirect to the trips page if given an invalid id" do
      # Your code here
      id = -1
      delete trip_path(id)
      must_redirect_to trips_path
    end
  end

  describe "assign_rating" do
    before do
      Trip.create!(cost: 7777, date: Date.current, passenger: Passenger.create(name: "sample passenger", phone_num: "999-999-9999"), driver: Driver.create(name: "Kari", vin: "WBWSS52P9NEYLVDE9", available: true))
    end
    it "will assign rating" do
      id = Trip.first.id

      expect{
        patch assign_rating_trip_path(id), params: {rating: 4}
      }.wont_change "Trip.count"

      must_respond_with :redirect

      expect(Trip.first.rating).must_equal 4
    end

    it "will redirect to the trips page if given an invalid id" do
      # Your code here
      id = -1
      delete trip_path(id)
      must_redirect_to trips_path
    end
  end
end

