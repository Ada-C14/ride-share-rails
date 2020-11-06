require "test_helper"

describe TripsController do
  let(:driver) do
    Driver.create! name: 'Ayesha', vin: 'BCTSH52M8YERVGDK9', available: true
  end

  let(:passenger) do
    Passenger.create! name: 'Roshni', phone_num: '123.456.7890'
  end

  let(:trip) do
    Trip.create! driver_id: driver.id, passenger_id: passenger.id, date: Date.today, rating: nil, cost: 10
  end

  describe "index" do
    it "responds with success when there are many trips saved" do
      get trips_path

      must_respond_with :success

    end

    it "responds with success when there are no trips saved" do
      get trips_path

      must_respond_with :success

    end
  end

  describe "show" do
    it "responds with success when showing an existing valid trip" do
      get trip_path(trip.id)

      must_respond_with :success
    end

    it "responds with 404 with an invalid trip id" do
      get trip_path(-1)

      # Assert
      must_respond_with :not_found

    end
  end

  describe "new" do
    it "responds with success" do
      driver
      get new_passenger_trip_path(passenger.id)

      # Assert
      must_respond_with :success
    end
  end

  describe "create" do
    it "can create a new trip with valid information accurately, and redirect" do
      trip_params = {
        trip: {
          driver_id: driver.id,
          passenger_id: passenger.id,
          date: Date.today.to_s,
          rating: nil,
          cost: 10
        }
      }
      expect do
        post trips_path, params: trip_params
      end.must_change 'Trip.count', 1

      new_trip = Trip.find_by(driver_id: trip_params[:trip][:driver_id])
      expect(new_trip.passenger_id).must_equal trip_params[:trip][:passenger_id]
      expect(new_trip.date).must_equal trip_params[:trip][:date]
      expect(new_trip.rating).must_equal trip_params[:trip][:rating]
      expect(new_trip.cost).must_equal trip_params[:trip][:cost]

      must_respond_with :redirect
      must_redirect_to trip_path(new_trip.id)
    end

    it 'will redirect to the trip_path' do
      trip_params = {
        trip: {
          driver_id: driver.id,
          passenger_id: passenger.id,
          date: Date.today,
          rating: nil,
          cost: 10
        }
      }

      post trips_path, params: trip_params

      new_trip = Trip.find_by(driver_id: trip_params[:trip][:driver_id])

      must_redirect_to trip_path(new_trip.id)
    end

    it 'will add a new trip to the database' do
      trip_params = {
        trip: {
          driver_id: driver.id,
          passenger_id: passenger.id,
          date: Date.today,
          rating: nil,
          cost: 10
        }
      }

      expect do
        post trips_path, params: trip_params
      end.must_change 'Trip.count', 1
    end

    it "does not create a trip if the form data violates Trip validations, and responds with a redirect" do
      trip_params = {
        trip: {
          driver_id: driver.id,
          passenger_id: nil,
          date: nil,
          rating: nil,
          cost: 10
        }
      }

      expect {
        post trips_path, params: trip_params
      }.must_differ "Trip.count", 0

      must_respond_with :redirect
    end
  end

  describe "edit" do
    it "responds with success when getting the edit page for an existing, valid passenger" do
      get edit_trip_path(trip.id)

      must_respond_with :success
    end

    it "responds with redirect when getting the edit page for a non-existing passenger" do
      get edit_trip_path(-1)

      must_respond_with :redirect
    end
  end

  describe "update" do
    before do
      Trip.create(driver_id: driver.id, passenger_id: passenger.id, date: Date.today, rating: nil, cost: 10)
    end
    let(:new_trip_hash) do
      {
        trip: {
          driver_id: driver.id,
          passenger_id: passenger.id,
          date: Date.today.to_s,
          rating: nil,
          cost: 10
        }
      }

    end
    it "can update an existing trip with valid information accurately, and redirect" do
      id = Trip.first.id
      expect do
        patch trip_path(id), params: new_trip_hash
      end.wont_change 'Trip.count'

      must_redirect_to trip_path(id)

      trip = Trip.find_by(id: id)

      expect(trip.driver_id).must_equal new_trip_hash[:trip][:driver_id]
      expect(trip.passenger_id).must_equal new_trip_hash[:trip][:passenger_id]
      expect(trip.date).must_equal new_trip_hash[:trip][:date]
      expect(trip.rating).must_equal new_trip_hash[:trip][:rating]
      expect(trip.cost).must_equal new_trip_hash[:trip][:cost]

    end

    it "does not update any trip if given an invalid id, and responds with a 404" do
      id = -1

      expect do
        patch trip_path(id), params: new_trip_hash
      end.wont_change 'Trip.count'

      must_respond_with :not_found
    end

    it "does not update a trip if the form data violates Trip validations, and responds with a redirect" do
      id = trip.id
      expect do
        patch trip_path(id), params: new_trip_hash
      end.wont_change 'Trip.count'

      must_redirect_to trip_path

    end

    describe "destroy" do
      it "destroys the trip instance in db when trip exists, then redirects to root_path" do
        new_trip = Trip.create(driver_id: driver.id, passenger_id: passenger.id, date: Date.today, rating: nil, cost: 10)

        new_trip.save

        id = new_trip.id

        # Act
        expect do
          delete trip_path(id)

          # Assert
        end.must_change 'Trip.count', -1

        must_respond_with :redirect
        must_redirect_to root_path
      end

      it "does not change the db when the driver does not exist, then responds with 404 " do
        id = -1

        expect do
          delete trip_path(id)
        end.wont_change 'Trip.count'

        must_respond_with :not_found
      end
    end
  end
end


