require "test_helper"

describe PassengersController do
  # Note: If any of these tests have names that conflict with either the requirements or your team's decisions, feel empowered to change the test names. For example, if a given test name says "responds with 404" but your team's decision is to respond with redirect, please change the test name.
  let (:passenger) {
    Passenger.create name: "sample passenger", phone_num: "000-000-0000"
  }
  describe "index" do
    it "responds with success when there are many passengers saved" do
      # Arrange
      # Ensure that there is at least one passenger saved
      passenger
      # # Act
      get passengers_path
      expect(Passenger.count).must_equal 1

      # Assert
      must_respond_with :success
    end

    it "responds with success when there are no passengers saved" do
      # Arrange
      # Ensure that there are zero passengers saved

      # Act
      get passengers_path
      expect(Passenger.count).must_equal 0

      # Assert
      must_respond_with :success
    end
  end

  describe "show" do
    it "responds with success when showing an existing valid passenger" do
      # Arrange
      # Ensure that there is a passenger saved
      passenger

      # Act
      get passenger_path(passenger.id)

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
      passenger
      get new_passenger_path

      must_respond_with :success
    end
  end

  describe "create" do
    it "can create a new passenger with valid information accurately, and redirect" do
      # Arrange
      # Set up the form data
      passenger_hash = {
          passenger: {
              name: "new task",
              phone_num: '000-000-0000'
          },
      }

      # Act-Assert
      # Ensure that there is a change of 1 in passenger.count
      expect {
        post passengers_path, params: passenger_hash
      }.must_change "Passenger.count", 1

      # Assert
      # Find the newly created passenger, and check that all its attributes match what was given in the form data
      new_passenger = Passenger.find_by(name: passenger_hash[:passenger][:name])
      # Check that the controller redirected the user
      must_respond_with :redirect
      must_redirect_to passengers_path(new_passenger.id)
      expect(new_passenger.name).must_equal passenger_hash[:passenger][:name]
      expect(new_passenger.phone_num).must_equal passenger_hash[:passenger][:phone_num]
    end

    it "does not create a passenger if the form data violates passenger validations, and responds with a redirect" do

      # Note: This will not pass until ActiveRecord Validations lesson
      # Arrange
      # Set up the form data so that it violates passenger validations
      passenger_hash = {
          passenger: {
              name: nil,
              phone_num: nil
          }
      }
      # Act-Assert
      # Ensure that there is no change in passenger.count
      expect {
        post passengers_path, params: passenger_hash
      }.must_differ "Passenger.count", 0

      # Assert
      # Check that the controller redirects
      must_respond_with :bad_request
    end
  end

  describe "edit" do
    it "responds with success when getting the edit page for an existing, valid passenger" do

      # Arrange
      # Ensure there is an existing passenger saved

      get edit_passenger_path(passenger.id)

      # Assert
      must_respond_with :success
    end

    it "responds with redirect when getting the edit page for a non-existing passenger" do
      # Arrange
      # Ensure there is an invalid id that points to no passenger
      get edit_passenger_path(-1)

      must_redirect_to root_path
    end
  end

  describe "update" do
    before do
      Passenger.create(name: "Bob Smith", phone_num: "000-000-0000")
    end

    let(:new_passenger_hash) {
      {
          passenger: {
              name: "Bob Smith",
              phone_num: "111-111-1111",
          },
      }
    }
    it "can update an existing passenger with valid information accurately, and redirect" do
      # Arrange
      # Ensure there is an existing passenger saved
      # Assign the existing passenger's id to a local variable
      # Set up the form data
      id = Passenger.first.id

      # Act-Assert
      # Ensure that there is no change in passenger.count
      expect {
        patch passenger_path(id), params: new_passenger_hash
      }.wont_change "Passenger.count"

      must_respond_with :redirect

      passenger = Passenger.find_by(id: id)
      expect(passenger.name).must_equal new_passenger_hash[:passenger][:name]
      expect(passenger.phone_num).must_equal new_passenger_hash[:passenger][:phone_num]

      # Assert
      # Use the local variable of an existing passenger's id to find the passenger again, and check that its attributes are updated
      # Check that the controller redirected the user
    end

    it "does not update any passenger if given an invalid id, and responds with a 404" do
      # Arrange
      # Ensure there is an invalid id that points to no passenger
      id = -1
      # Set up the form data


      # Act-Assert
      # Ensure that there is no change in passenger.count
      expect {
        patch passenger_path(id), params: new_passenger_hash
      }.wont_change "Passenger.count"


      # Assert
      # Check that the controller gave back a 404
      must_respond_with :not_found
      # must_redirect_to root_path
    end

    it "does not create a passenger if the form data violates passenger validations, and responds with a redirect" do

      # Note: This will not pass until ActiveRecord Validations lesson
      # Arrange
      # Ensure there is an existing passenger saved
      # Assign the existing passenger's id to a local variable

      # Set up the form data so that it violates passenger validations

      # Act-Assert
      # Ensure that there is no change in passenger.count

      # Assert
      # Check that the controller redirects
      new_passenger_hash[:passenger][:phone_num] = nil
      passenger = Passenger.first

      expect {
        patch passenger_path(passenger.id), params: new_passenger_hash
      }.wont_change "Passenger.count"

      passenger.reload # refresh the book from the database
      expect(passenger.phone_num).wont_be_nil
      must_respond_with :redirect
      must_redirect_to root_path

    end
  end

  describe "destroy" do
    it "destroys the passenger instance in db when passenger exists, then redirects" do
      # Arrange
      # Ensure there is an existing passenger saved

      # Act-Assert
      # Ensure that there is a change of -1 in passenger.count

      # Assert
      # Check that the controller redirects
      passenger_name_to_delete = "Test passenger"
      passenger_to_delete = Passenger.create(name: passenger_name_to_delete, phone_num: "222-222-2222")

      # Act
      expect {
        delete passenger_path(passenger_to_delete.id)
      }.must_change "Passenger.count", -1

      deleted_passenger = Passenger.find_by(name: passenger_name_to_delete)
      expect(deleted_passenger).must_be_nil

      must_respond_with :redirect
      must_redirect_to passengers_path
    end

    it "does not change the db when the passenger does not exist, then responds with " do
      # Arrange
      # Ensure there is an invalid id that points to no passenger

      # Act-Assert
      # Ensure that there is no change in passenger.count

      # Assert
      # Check that the controller responds or redirects with whatever your group decides
      expect {
        delete passenger_path(-1)
      }.wont_change "Passenger.count"

      must_respond_with :not_found
    end
  end

end
