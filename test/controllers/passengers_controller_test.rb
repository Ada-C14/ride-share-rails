require "test_helper"

describe PassengersController do
  # Note: If any of these tests have names that conflict with either the requirements or your team's decisions, feel empowered to change the test names. For example, if a given test name says "responds with 404" but your team's decision is to respond with redirect, please change the test name.

  let (:passenger) {
    Passenger.create(name: "Shane Doe", phone_number: "HKJS12345HJGS")
  }

  describe "index" do
    it "responds with success when there are many passengers saved" do
      # Arrange
      # Ensure that there is at least one passenger saved
      p = passenger
      # Act
      get passengers_path
      # Assert
      must_respond_with :success
    end

    it "responds with success when there are no passengers saved" do
      # Arrange
      # Ensure that there are zero passengers saved

      # Act
      get passengers_path
      # Assert
      must_respond_with :success
    end
  end

  describe "show" do
    it "responds with success when showing an existing valid passenger" do
      # Arrange
      # Ensure that there is a passenger saved
      p = passenger
      # Act
      get passenger_path(p.id)
      # Assert
      must_respond_with :success

    end

    it "responds with 404 with an invalid passenger id" do
      # Arrange
      # Ensure that there is an id that points to no passenger

      # Act
      get passenger_path(-1)
      # Assert
      must_respond_with :not_found
    end
  end

  describe "new" do
    it "responds with success" do

      # Act
      get new_passenger_path

      # Assert
      must_respond_with :success
    end
  end

  describe "create" do
    it "can create a new passenger with valid information accurately, and redirect" do
      # Arrange
      # Set up the form data
      passenger_hash = {
          passenger: {
              name: "Sally Sombody",
              phone_number: "HKJHSIU3467854",
          }
      }
      # Act-Assert
      # Ensure that there is a change of 1 in passenger.count
      expect {
        post passengers_path, params: passenger_hash
      }. must_differ "Passenger.count", 1

      # Assert
      # Find the newly created passenger, and check that all its attributes match what was given in the form data
      # Check that the controller redirected the user


      new_passenger = Passenger.last

      expect(new_passenger.name).must_equal passenger_hash[:passenger][:name]
      expect(new_passenger.phone_number).must_equal passenger_hash[:passenger][:phone_number]

      must_respond_with :redirect
      must_redirect_to passenger_path(new_passenger.id)
    end

    it "does not create a passenger if the form data violates passenger validations, and responds with a redirect" do
      # Note: This will not pass until ActiveRecord Validations lesson
      # Arrange
      # Set up the form data so that it violates passenger validations
      invalid_passenger_hash = {
          passenger: {
              name: "Name only"
          }
      }

      # Act-Assert
      # Ensure that there is no change in passenger.count
      expect{
        post passengers_path, params: invalid_passenger_hash
      }.wont_change "Passenger.count"

      # Assert
      # Check that the controller redirects
      must_respond_with :success
    end
  end

  before do
    Passenger.create(name: "Anna Bobby", phone_number: "BFJHD2345654")
  end
  let(:new_passenger) {
    {
        passenger: {
            name: "Sarah Copper",
            phone_number: "CKJEU3245765KJBK",
        },
    }
  }

  describe "edit" do
    it "responds with success and redirect when getting the edit page for an existing, valid passenger" do
      # Arrange
      # Ensure there is an existing passenger saved
      passenger = Passenger.find_by(name: "Anna Bobby")
      # Act
      get edit_passenger_path(passenger.id)
      # Assert
      must_respond_with :success
    end

    it "responds with redirect when getting the edit page for a non-existing passenger" do
      # Arrange
      # Ensure there is an invalid id that points to no passenger

      # Act
      get edit_passenger_path(-1)
      # Assert
      must_respond_with :not_found

    end
  end

  describe "update" do
    it "can update an existing passenger with valid information accurately, and redirect" do
      # Arrange
      # Ensure there is an existing passenger saved
      # Assign the existing passenger's id to a local variable
      # Set up the form data

      found_passenger = Passenger.find_by(name: "Anna Bobby")

      # Act-Assert
      # Ensure that there is no change in passenger.count

      expect{
        patch passenger_path(found_passenger.id), params: new_passenger
      }. wont_change "Passenger.count"

      must_redirect_to passenger_path(found_passenger.id)

      # Assert
      # Use the local variable of an existing passenger's id to find the passenger again, and check that its attributes are updated
      # Check that the controller redirected the user

      found_passenger.reload
      expect(found_passenger.name).must_equal new_passenger[:passenger][:name]
      expect(found_passenger.phone_number).must_equal new_passenger[:passenger][:phone_number]

    end

    it "does not update any passenger if given an invalid id, and responds with a 404" do
      # Arrange
      # Ensure there is an invalid id that points to no passenger
      # Set up the form data

      # Act-Assert
      # Ensure that there is no change in passenger.count
      expect{
        patch passenger_path(-1), params: new_passenger
      }. wont_change "Passenger.count"

      # Assert
      # Check that the controller gave back a 404
      must_respond_with :not_found
    end

    it "does not create a passenger if the form data violates passenger validations, and responds with a redirect" do
      # Note: This will not pass until ActiveRecord Validations lesson
      # Arrange
      # Ensure there is an existing passenger saved
      # Assign the existing passenger's id to a local variable

      found_passenger = Passenger.find_by(name: "Anna Bobby")

      # Set up the form data so that it violates passenger validations

      invalid_passenger_hash = {
          passenger: {
              phone_number: "phone number only"
          }
      }

      # Act-Assert
      # Ensure that there is no change in passenger.count
      expect{
        patch passenger_path(found_passenger.id), params: invalid_passenger_hash
      }.wont_change "Passenger.count"

      # Assert
      # Check that the controller redirect
      must_respond_with :redirect
      must_redirect_to passenger_path(found_passenger.id)

      #check to make sure attempted save with invalid params did not overwrite previously saved object
      refound_passenger = Passenger.find_by(name: "Anna Bobby")
      expect(refound_passenger).must_equal found_passenger
    end
  end

  describe "destroy" do
    it "destroys the passenger instance in db when passenger exists, then redirects" do
      # Arrange
      # Ensure there is an existing passenger saved
      passenger_to_delete = Passenger.find_by(name: "Anna Bobby")
      # Act-Assert
      # Ensure that there is a change of -1 in passenger.count
      expect {
        delete passenger_path(passenger_to_delete.id)
      }.must_differ "Passenger.count", -1
      # Assert
      # Check that the controller redirects

      passenger_to_delete = Passenger.find_by(name: "Anna Bobby")

      expect(passenger_to_delete).must_be_nil

      must_redirect_to passengers_path

    end

    it "does not change the db when the passenger does not exist, then responds with " do
      # Arrange
      # Ensure there is an invalid id that points to no passenger

      # Act-Assert
      # Ensure that there is no change in passenger.count
      expect{
        delete passenger_path(-1)
      }.wont_change "Passenger.count"
      # Assert
      # Check that the controller responds or redirects with whatever your group decides

      must_respond_with :not_found
    end
  end
end
