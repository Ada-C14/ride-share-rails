require "test_helper"

describe TripsController do
  describe "show" do
    # Your tests go here
    it 'responds with Not Found when given an invalid trip id' do
      get trip_path('roller coaster')

      must_respond_with :not_found
    end

    it "can get a valid trip" do

      get trip_path(trip.id)
      must_respond_with :success
    end
  end

  describe "create" do
    # Your tests go here
    it "creates a new trip" do
      pass = Passenger.create(name: 'Denise', phone_num: '123-456-7890')
      driver = Driver.create(name: 'Pink Panther', vin: '123', available: true)

      trip_info = {
          trip: {
              driver_id: driver.id,
              passenger_id: pass.id,
              date: Date.today,
              cost: nil,
              rating: nil
          }
      }

      expect {
        post passenger_trips_path(pass), params: trip_info
      }.must_differ "Trip.count", 1

      new_trip = Trip.find_by(passenger_id: trip_info[:trip][:passenger_id])
      expect(new_trip.date).must_equal trip_info[:trip][:date]
      expect(new_trip.cost).must_be_kind_of Integer
      expect(new_trip.rating).must_equal trip_info[:trip][:rating]
      expect(new_trip.driver_id).must_equal trip_info[:trip][:driver_id]

      must_respond_with :redirect
      must_redirect_to trip_path(new_trip)
    end
  end

  describe "edit" do
    # Your tests go here
  end

  describe "update" do
    # Your tests go here
  end

  describe "destroy" do
    # Your tests go here
  end
end
