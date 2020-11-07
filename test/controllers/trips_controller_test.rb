require "test_helper"

describe TripsController do

  describe "show" do
    # Your tests go here
    it 'responds with Not Found when given an invalid trip id' do
      get trip_path(-1)

      must_respond_with :not_found
    end

    it 'responds with success when showing an existing valid trip' do
      fake_passenger = Passenger.create(name: 'CheezItMan', phone_num: '123-456-7890')
      fake_driver = Driver.create(name: 'Devin', vin: '98765445678912345', available: true)
      fake_trip = Trip.create(driver_id: fake_driver.id, passenger_id: fake_passenger.id, date: Date.today, rating: nil, cost: 25)

      get trip_path(fake_trip)

      must_respond_with :success
    end
  end

  describe "create" do
    # Your tests go here
    it "can create a new trip with valid information accurately, and redirect" do
      fake_passenger = Passenger.create(name: 'CheezItMan', phone_num: '123-456-7890')

      trip_info = {
          trip: {
              passenger_id: fake_passenger.id,
              date: Date.today,
              rating: nil,
              cost: nil
          }
      }

      expect {
        post passenger_trips_path(fake_passenger), params: trip_info
      }.must_differ "Trip.count", 1

      new_trip = Trip.find_by(passenger_id: trip_info[:trip][:passenger_id])
      expect(new_trip.date).must_equal trip_info[:trip][:date]
      expect(new_trip.cost).must_be_kind_of Integer
      expect(new_trip.rating).must_equal trip_info[:trip][:rating]

      must_respond_with :redirect
      must_redirect_to trip_path(new_trip)
    end
  end

  describe "edit" do
    # Your tests go here
    it "can successfuly edit a trip" do
      passenger = Passenger.create!(name: 'Jonah', phone_num: '123-345-7890')
      driver = Driver.create!(name: 'Snowy', vin: '12341239876754345', available: true)
      old_trip = Trip.create!(driver_id: driver.id, passenger: passenger, date: Date.today, rating: nil, cost: 70)

      get edit_trip_path(old_trip)

      must_respond_with :success
    end
  end

  describe "update" do
    # Your tests go here
    it " ill name it later" do
      fake_passenger = Passenger.create(name: 'CheezItMan', phone_num: '123-456-7890')
      fake_driver = Driver.create(name: 'Devin', vin: '98765445678912345', available: true)
      old_trip = Trip.create(driver_id: fake_driver.id, passenger_id: fake_passenger.id, date: Date.today, rating: nil, cost: 70)

      old_trip_id = old_trip.id

      updated_trip = {
          trip: {
              driver_id: fake_driver.id,
              passenger_id: fake_passenger.id,
              date: Date.today,
              rating: 3,
              cost: 60
          }
      }
      expect { patch trip_path(old_trip), params: updated_trip }.wont_change "Trip.count"

      updated_ride = Trip.find_by(id: old_trip_id)
      expect(updated_ride.passenger_id).must_equal updated_trip[:trip][:passenger_id]
      expect(updated_ride.driver_id).must_equal updated_trip[:trip][:driver_id]
      expect(updated_ride.date).must_equal updated_trip[:trip][:date]
      expect(updated_ride.cost).must_equal updated_trip[:trip][:cost]
      expect(updated_ride.rating).must_equal updated_trip[:trip][:rating]

      must_respond_with :redirect
      must_redirect_to trip_path(updated_ride)
    end
  end

  describe "destroy" do
    # Your tests go here
    it "Deletes an instance of trip and redirects" do

      fake_passenger = Passenger.create(name: 'Alanis', phone_num: '123-456-7890')
      fake_driver = Driver.create(name: 'Pitrico', vin: '09876543212345678', available: true)
      discarded_trip = Trip.create(driver_id: fake_driver.id, passenger_id: fake_passenger.id, date: Date.today, rating: nil, cost: 70)

      expect {delete trip_path(discarded_trip)}.must_differ "Trip.count", -1
    end

    it "does not change the Database when trying to delete an invalid trip" do

      invalid_id = 'bad id'

      expect {delete trip_path(invalid_id)}.wont_change "Trip.count"
    end
  end

end
