require "test_helper"

describe PassengersController do

  before do
    @passenger = Passenger.create name: 'Test Passenger', phone_num: '293-293-2938'
  end

  describe "index" do
    it "responds with success when there are many passengers saved" do
      # Act
      get passengers_path

      # Assert
      must_respond_with :success

    end

    it "responds with success when there are no passengers saved" do
      #Arrange
      @passenger.destroy

      # Act
      get passengers_path

      # Assert
      must_respond_with :success

    end

  end

  describe "show" do
    it "responds with success when showing an existing valid oassenger" do
      # Act
      get passenger_path(@passenger.id)

      # Assert
      must_respond_with :success
    end

    it "responds with 404 with an invalid passenger id" do

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
              name: "new passenger",
              phone_num: "1203945034",
          },
      }

      # Act-Assert
      # Ensure that there is a change of 1 in passenger.count
      expect {
        post passengers_path, params: passenger_hash
      }.must_change "Passenger.count", 1

      # Assert
      # Find the newly created passenger, and check that all its attributes match what was given in the form data
      # Check that the controller redirected the user
      new_passenger = Passenger.find_by(name: passenger_hash[:passenger][:name])
      expect(new_passenger.phone_num).must_equal passenger_hash[:passenger][:phone_num]

      must_respond_with :redirect
      must_redirect_to passenger_path(new_passenger.id)

    end

    it "does not create a passenger if the form data violates passenger validations" do
      # Note: This will not pass until ActiveRecord Validations lesson
      # Arrange
      # Set up the form data so that it violates passenger validations
      passenger_hash = {
          passenger: {
              name: "",
              phone_num: "",
          }
      }
      # Act-Assert
      expect {
        post passengers_path, params: passenger_hash
      }.wont_differ "Passenger.count"

    end  
  end

  describe "edit" do
    it "responds with success when getting the edit page for an existing, valid passenger" do
      # Arrange
      # Ensure there is an existing passenger saved

      # Act
      get edit_passenger_path(@passenger.id)

      # Assert
      must_respond_with :success
    end

    it "responds with redirect when getting the edit page for a non-existing passenger" do
      # Arrange
      # Ensure there is an invalid id that points to no passenger

      # Act
      get edit_passenger_path(-1)

      # Assert
      must_respond_with :redirect

    end
  end
  describe "update" do
    it "can update an existing passenger with valid information accurately, and redirect" do
      # Arrange
      # Ensure there is an existing passenger saved
      # Assign the existing passenger's id to a local variable
      id = @passenger.id
      # Set up the form data
      new_data = {
          passenger: {
              name: "new name",
              phone_num: "new phone_num"
          }
      }

      # Act-Assert
      # Ensure that there is no change in passenger.count
      expect {
        patch passenger_path(id), params: new_data
      }.wont_differ "Passenger.count"

      # Assert
      # Use the local variable of an existing passenger's id to find the passenger again, and check that its attributes are updated
      # Check that the controller redirected the user
      new_passenger = Passenger.find_by(id: id)
      expect(new_passenger.name).must_equal new_data[:passenger][:name]
      expect(new_passenger.phone_num).must_equal new_data[:passenger][:phone_num]

      must_respond_with :redirect
      must_redirect_to passenger_path(id)

    end

    it "does not update any passenger if given an invalid id, and responds with a 404" do
      # Arrange
      # Ensure there is an invalid id that points to no passenger
      # Set up the form data
      id = -1
      new_data = {
          passenger: {
              name: "new name",
              phone_num: "new phone_num"
          }
      }

      # Act-Assert
      # Ensure that there is no change in passenger.count
      expect {
        patch passenger_path(id), params: new_data
      }.wont_change "Passenger.count"

      # Assert
      # Check that the controller gave back a 404
      must_respond_with :not_found

    end
  end

  describe "destroy" do
    it "destroys the passenger instance in db when passenger exists, then redirects" do
      # Arrange
      # Ensure there is an existing passenger saved
      id = @passenger.id

      # Act-Assert
      # Ensure that there is a change of -1 in passenger.count
      expect {
        delete passenger_path(id)
      }.must_change 'Passenger.count', -1

      # Assert
      # Check that the controller redirects
      deleted_passenger = Passenger.find_by(id: id)

      expect(deleted_passenger).must_be_nil

      must_respond_with :redirect
      must_redirect_to passengers_path

    end

    it "does not change the db when the passenger does not exist, then responds with redirect" do
      # Arrange
      # Ensure there is an invalid id that points to no passenger
      @passenger.destroy

      # Act-Assert
      # Ensure that there is no change in passenger.count
      expect {
        delete passenger_path(@passenger.id)
      }.wont_differ 'Passenger.count'

      # Assert
      # Check that the controller responds or redirects with whatever your group decides
      must_respond_with :redirect
      must_redirect_to passengers_path

    end
  end
end


