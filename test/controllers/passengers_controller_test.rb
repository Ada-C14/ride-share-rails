require "test_helper"

describe PassengersController do

  let (:passenger) {
    Passenger.create(name: "Test Passenger", phone_num: "2065550000")
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
      # Arrange
      # Ensure that there is an id that points to no passenger

      # Act
      get passenger_path(-1)

      # Assert
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
              name: "new passenger",
              phone_num: "4255550000"
          }
      }

      # Act-Assert
      # Ensure that there is a change of 1 in passenger.count
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
      # Ensure that there is no change in passenger.count
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
      get edit_passenger_path(passenger.id)
      # Assign the existing passenger's id to a local variable
      # Set up the form data
      edited_passenger_hash = {
          passenger: {
              name: "Test passenger 2",
              phone_num: "3605550000"
          }
      }

      # Act-Assert
      # Ensure that there is no change in passenger.count
      expect {
        patch passenger_path(passenger.id), params: edited_passenger_hash
      }.wont_change "Passenger.count"

      # Assert
      # Use the local variable of an existing passenger's id to find the passenger again, and check that its attributes are updated
      # Check that the controller redirected the user
      edited_passenger = Passenger.find_by(id: passenger.id)
      expect(edited_passenger.name).must_equal edited_passenger_hash[:passenger][:name]
      expect(edited_passenger.phone_num).must_equal edited_passenger_hash[:passenger][:phone_num]

      must_respond_with :redirect
      must_redirect_to passenger_path(passenger.id)
    end

    it "does not update any passenger if given an invalid id, and redirects to list of passengers" do
      # Arrange
      # Ensure there is an invalid id that points to no passenger
      # Set up the form data
      edited_passenger_hash = {
          passenger: {
              name: "Test passenger 2",
              phone_num: "5095550000"
          }
      }

      # Act-Assert
      # Ensure that there is no change in passenger.count
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
      get edit_passenger_path(passenger.id)

      # Set up the form data so that it violates passenger validations
      edited_passenger_hash = {
          passenger: {
              name: "",
              phone_num: ""
          }
      }

      # Act-Assert
      # Ensure that there is no change in passenger.count
      expect {
        patch passenger_path(passenger.id), params: edited_passenger_hash
      }.wont_change "Passenger.count"

      # Assert
      # Check that the controller redirects
      must_respond_with :bad_request
    end
  end

  describe "destroy" do
    # Your tests go here
  end
end
