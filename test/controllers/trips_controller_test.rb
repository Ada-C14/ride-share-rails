require "test_helper"

describe TripsController do
  describe "show" do
    # Your tests go here
    it 'responds with Not Found when given an invalid trip id' do
      get trip_path('roller coaster')

      must_respond_with :not_found
    end

    it 'responds with success when showing an existing valid trip' do
      fake_passenger = Passenger.create(name: 'CheezItMan', phone_num: '123-456-7890')
      fake_driver = Driver.create(name: 'Devin', vin: 567, available: true)
      trip = Trip.create(passenger_id: fake_passenger.id, driver_id: fake_driver.id, date: Date.today, cost: 25, rating: nil)

      get trip_path(trip)

      must_respond_with :success
    end
  end

  describe "create" do
    # Your tests go here
    it "can create a new trip with valid information accurately, and redirect" do
      fake_passenger = Passenger.create(name: 'CheezItMan', phone_num: '123-456-7890')
      fake_driver = Driver.create(name: 'Devin', vin: 567, available: true)

      trip_info = {
        trip: {
          driver_id: fake_driver.id,
          passenger_id: fake_passenger.id,
          date: Date.today,
          cost: nil,
          rating: nil
        }
      }

      expect {
        post passenger_trips_path(fake_passenger), params: trip_info
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
