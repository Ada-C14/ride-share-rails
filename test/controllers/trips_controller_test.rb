require "test_helper"

# describe TripsController do
#   skip
#   describe "show" do
#     # Your tests go here
#   end

#   describe "create" do
#     # Your tests go here
#   end

#   describe "edit" do
#     # Your tests go here
#   end

#   describe "update" do
#     # Your tests go here
#   end

#   describe "destroy" do
#     # Your tests go here
#   end
# end

describe TripsController do
  before do
    @trip = Trip.create!(driver_id: @driver.id, trip_id: @trip.id, date: Time.now, rating: nil, cost: rand(1..1000)
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
      must_redirect_to trips_path
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
      trip_hash = {
        driver_id: @driver.id,
        passenger_id: @passenger.id,
        date: Time.now,
        rating: nil,
        cost: rand(1..1000)
        }
      }

      expect {
        post trips_path, params: trip_hash
      }.must_differ 'trip.count', 1

      new_trip = trip.find_by(name: trip_hash[:trip][:name])
      expect(new_trip.driver_id).must_equal trip_hash[:trip][:driver_id]
      expect(new_trip.passenger_id).must_equal trip_hash[:trip][:passenger_id]

      must_respond_with :redirect
      must_redirect_to trips_path(new_trip.id)

    end

    it "does not create a trip if violate Validation rules" do
      skip
       # Arrange
       trip_hash = {
        trip: {
          phone_num: '123456',
        }
      }

      # Act-Assert
      expect {
        post trips_path, params: trip_hash
      }.wont_change 'trip.count'

      # Ensure that there is no change in trip.count

      # Assert
      must_respond_with :success
    end

    it "does not create a trip if missing driver_id" do
      skip
      # Arrange
      trip_hash = {
       trip: {
         phone_num: 123456,
       }
     }

     # Act-Assert
     expect {
       post trips_path, params: trip_hash
     }.wont_change 'trip.count'

     # Ensure that there is no change in trip.count

     # Assert
     must_respond_with :success
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
      must_redirect_to trips_path
    end
  end

  describe "update" do
    let (:new_trip_hash) {
      {
        trip: {
          name: 'A Wrinkle in Time',
          phone_num: 22222
        }
      }
    }
    it "can update an existing trip with valid information accurately, and redirect" do
      # Act-Assert
      expect {
        patch trip_path(@trip.id), params: new_trip_hash # the params method set the data structure 
        }.wont_change 'trip.count'
      # Ensure that there is no change in trip.count

      # Assert
      trip = trip.find_by(id: @trip.id)
      expect(trip.name).must_equal new_trip_hash[:trip][:name]
      expect(trip.phone_num).must_equal new_trip_hash[:trip][:phone_num]

      must_respond_with :redirect
      must_redirect_to trips_path
    end

    it "does not update any trip if given an invalid id, and responds with a redirect" do
      # Arrange
      patch trip_path(-1)

      # Act-Assert
      expect {
        patch trip_path(-1), params: new_trip_hash # the params method set the data structure 
        }.wont_change 'trip.count'
      # Ensure that there is no change in trip.count

      # Assert
      must_respond_with :redirect
      must_redirect_to trips_path
    end

    it "does not update a trip if the form data violates trip validations, and responds with a sucess" do
       # Arrange
       trip_hash = {
        trip: {
          name: ""
        }
      }

      # Act-Assert
      expect {
        patch trip_path(id: @trip.id), params: trip_hash
      }.wont_change 'trip.count'

      # Ensure that there is no change in trip.count

      # Assert
      must_respond_with :success
    end
  end

  describe "destroy" do
    it "destroys the trip instance in db when trip exists, then redirects" do
      expect {
        delete trip_path(@trip.id)

      # Assert
      }.must_change 'trip.count', -1
    
      trip = trip.find_by(name: @trip.name)

      expect(trip).must_be_nil

      must_respond_with :redirect
      must_redirect_to trips_path
    end

    it "does not change the db when the trip does not exist, then responds with redirect " do
      expect {
        delete trip_path(-1)
      }.wont_change 'trip.count'

      must_respond_with :redirect
      must_redirect_to trips_path
    end
  end
end

