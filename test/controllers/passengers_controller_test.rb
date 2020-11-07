require "test_helper"

describe PassengersController do

  let (:passenger) {
    Passenger.create(name: "Test Passenger", phone_num: "206-555-5555")
  }

  describe "index" do
    # Your tests go here
    it "responds with success when there are many passengers saved" do
      # Arrange
      # Ensure that there is at least one Passenger saved
      passenger
      expect(Passenger.count).must_equal 1

      # Act
      get passengers_path

      # Assert
      must_respond_with :success
    end

    it "responds with success when there are no passenger saved" do
      # Arrange
      # Ensure that there are zero passengers saved
      expect(Passenger.count).must_equal 0

      # Act
      get passengers_path

      # Assert
      must_respond_with :success
    end
  end

  describe "show" do
    # Your tests go here
    it "responds with success when showing an existing valid passenger" do
      # Arrange
      # Ensure that there is a passenger saved

      # Act
      get passenger_path(passenger.id)

      # Assert
      must_respond_with :success
    end

    it "responds with redirect with an invalid passenger id" do
      get passenger_path(-1)

      must_respond_with :redirect
      must_redirect_to passengers_path
    end
  end

  describe "new" do
    # Your tests go here
    it "responds with success" do
      get new_passenger_path

      must_respond_with :success
    end
  end

  describe "create" do
    # Your tests go here
    it "can create a new passenger with valid information accurately, and redirect" do
      # Arrange
      # Set up the form data
      passenger_hash = {
          passenger: {
              name: "New Passenger",
              phone_num: "425-555-5555"
          }
      }

      # Act-Assert
      # Ensure that there is a change of 1 in Passenger.count
      expect {
        post passengers_path, params: passenger_hash
      }.must_change "Passenger.count", 1

      # Assert
      # Find the newly created passenger, and check that all its attributes match what was given in the form data
      new_passenger = Passenger.find_by(name: passenger_hash[:passenger][:name])
      expect(new_passenger.phone_num).must_equal passenger_hash[:passenger][:phone_num]

      # Check that the controller redirected the user
      must_respond_with :redirect
      must_redirect_to passenger_path(new_passenger.id)
    end

    it "does not create a passenger if the form data violates passenger validations, and responds with a redirect" do
      # Note: This will not pass until ActiveRecord Validations lesson
      # Arrange
      # Set up the form data so that it violates passenger validations
      passenger_hash = {
          passenger: {
              name: "",
              phone_num: ""
          }
      }

      # Act-Assert
      # Ensure that there is no change in Passenger.count
      expect {
        post passengers_path, params: passenger_hash
      }.wont_change "Passenger.count"

      # Assert
      # Check that the controller redirects
      must_respond_with :bad_request
    end
  end

  describe "edit" do
    # Your tests go here
    it "responds with success when getting the edit page for an existing, valid passenger" do
      # Arrange
      # Ensure there is an existing passenger saved
      get edit_passenger_path(passenger.id)

      must_respond_with :success
    end

    it "responds with redirect when getting the edit page for a non-existing passenger" do
      # Arrange
      # Ensure there is an invalid id that points to no passenger
      get edit_passenger_path(-1)

      must_respond_with :redirect
      must_redirect_to passengers_path
    end
  end

  describe "update" do
    # Your tests go here
    it "can update an existing passenger with valid information accurately, and redirect" do
      # Arrange
      # Ensure there is an existing passenger saved
      passenger_id = passenger.id
      # Assign the existing passenger's id to a local variable
      # Set up the form data
      edited_passenger_hash = {
          passenger: {
              name: "Test Passenger 2",
              phone_num: "360-555-5555"
          }
      }

      # Act-Assert
      # Ensure that there is no change in Passenger.count
      expect {
        patch passenger_path(passenger_id), params: edited_passenger_hash
      }.wont_change "Passenger.count"

      # Assert
      # Use the local variable of an existing passenger's id to find the passenger again, and check that its attributes are updated
      # Check that the controller redirected the user
      edited_passenger = Passenger.find_by(id: passenger_id)
      expect(edited_passenger.name).must_equal edited_passenger_hash[:passenger][:name]
      expect(edited_passenger.phone_num).must_equal edited_passenger_hash[:passenger][:phone_num]

      must_respond_with :redirect
      must_redirect_to passenger_path(passenger_id)
    end

    it "does not update any passenger if given an invalid id, and redirects to list of passengers" do
      # Arrange
      # Ensure there is an invalid id that points to no passenger
      # Set up the form data
      edited_passenger_hash = {
          passenger: {
              name: "Test Passenger 2",
              phone_num: "360-555-5555"
          }
      }

      # Act-Assert
      # Ensure that there is no change in Passenger.count
      expect {
        patch passenger_path(-1), params: edited_passenger_hash
      }.wont_change "Passenger.count"

      # Assert
      # Check that the controller gave back a 404
      must_respond_with :not_found
    end

    it "does not create a passenger if the form data violates passenger validations, and responds with a redirect" do
      # Note: This will not pass until ActiveRecord Validations lesson
      # Arrange
      # Ensure there is an existing passenger saved
      # Assign the existing passenger's id to a local variable
      passenger_id = passenger.id

      # Set up the form data so that it violates passenger validations
      edited_passenger_hash = {
          passenger: {
              name: "",
              phone_num: ""
          }
      }

      # Act-Assert
      # Ensure that there is no change in Passenger.count
      expect {
        patch passenger_path(passenger_id), params: edited_passenger_hash
      }.wont_change "Passenger.count"

      # Assert
      # Check that the controller redirects
      must_respond_with :bad_request
    end
  end

  describe "destroy" do
    it "destroys the passenger instance in db when passenger exists and has no trips, then redirects" do
      passenger_id = passenger.id

      expect {
        delete passenger_path(passenger_id)
      }.must_change 'Passenger.count', -1

      deleted_passenger = Passenger.find_by(id: passenger_id)

      expect(deleted_passenger).must_be_nil

      must_respond_with :redirect
      must_redirect_to passengers_path
    end

    it "does not change the db when passenger exists and has trips, must respond with bad request" do
      passenger_id = passenger.id
      driver = Driver.create(name: "Test Driver", vin: "12345678912345678", available: true)
      Trip.create(date: "2020-11-05",
                  rating: nil,
                  cost: 1000,
                  passenger_id: passenger_id,
                  driver_id: driver.id)

      expect {
        delete passenger_path(passenger_id)
      }.wont_change 'Passenger.count'

      passenger_with_trips = Passenger.find_by(id: passenger_id)

      expect(passenger_with_trips).must_equal passenger

      must_respond_with :redirect
      must_redirect_to passenger_path(passenger_id)
    end

    it "does not change the db when the passenger does not exist, then responds with not found" do
      expect {
        delete passenger_path(-1)
      }.wont_change 'Passenger.count'

      must_respond_with :not_found
    end
  end
end
