require "test_helper"

describe PassengersController do
  let(:passenger) {
    Passenger.create name: "passenger name", phone_num: "phone number"
  }
  describe "index" do
    it "responds with success when there are many passengers saved" do #PASSING
      # Arrange
      get passengers_path
      #Act
      must_respond_with :success
      # Assert
    end

    it "responds with success when there are no passengers saved" do
      # Arrange
      # Ensure that there are zero drivers saved
      # Act
      # Assert

    end
  end

  describe "show" do
    # Your tests go here
    it "responds with success when showing an existing valid passenger" do #Passing
      #Arrange
      get passenger_path(passenger.id)
      # Act
      must_respond_with :success

      # Assert
    end

    it "responds with 404 with an invalid driver id" do  #Passing
      #Arrange
      get passenger_path(-10)
      # Act
      must_respond_with :not_found
      # Assert
    end
  end

  describe "new" do
    it "responds with success" do
      # Your tests go here
    end
  end

  describe "create" do
    it "can create a new driver with valid information accurately, and redirect" do #PASSING
                                                                                    # Arrange # Set up the form data
    new_passenger_hash = {
        passenger:{
            name: "Lip Gloss Poppin",
            phone_num: "call ( me ) beep me"
        }
    }
                                                                                    # Act-Assert # Ensure that there is a change of 1 in Driver.count
    expect {
      post passenger_path, params: new_passenger_hash
    }.must_change "Passenger.count", 1
                                                                                    # Assert
                                                                                    # Find the newly created Driver, and check that all its attributes match what was given in the form data
                                                                                    # Check that the controller redirected the user
    new_passenger = Passenger.find_by(name: new_passenger_hash[:passenger][:name])
    expect(new_passenger.phone_num).must_equal new_passenger_hash[:driver][:phone_num]
                                                                                    # expect(new_driver.available).must_equal true

    must_respond_with :redirect
    must_redirect_to passenger_path(new_passenger.id) # Your tests go here
    end

    it "does not create a driver if the form data violates Driver validations, and responds with a redirect" do  #PASSING
                                                                                                                 # Note: This will not pass until ActiveRecord Validations lesson
                                                                                                                 # Arrange
                                                                                                                 # Set up the form data so that it violates Driver validations
    driver_hash = {
        driver: {
            name: nil,
            vin: nil,
        },
    }
                                                                                                                 # Act-Assert
    expect {
      post drivers_path, params: driver_hash
    }.wont_change "Driver.count"

                                                                                                                 # Assert
    must_respond_with :not_found
    end
  end

  describe "edit" do
    it "responds with success when getting the edit page for an existing, valid driver" do #PASSING
                                                                                           # Arrange
                                                                                           # Ensure there is an existing driver saved

                                                                                           # Assert

    end
    # Your tests go here
    #
    it "responds with redirect when getting the edit page for a non-existing driver" do  #PASSING
                                                                                         # Arrange

    end
  end

  describe "update" do
    it "can update an existing driver with valid information accurately, and redirect" do  #PASSING
                                                                                           # Arrange
                                                                                           # Ensure there is an existing driver saved' # Assert
                                                                                           # Use the local variable of an existing driver's id to find the driver again, and check that its attributes are updated
                                                                                           # Check that the controller redirected the user

    end

    it "does not update any driver if given an invalid id, and responds with a 404" do
      # Arrange
      # Ensure there is an invalid id that points to no driver
      # Set up the form data

      # Act-Assert
      # Ensure that there is no change in Driver.count

      # Assert
      # Check that the controller gave back a 404

    end

    it "does not create a driver if the form data violates Driver validations, and responds with a redirect" do
      # Note: This will not pass until ActiveRecord Validations lesson
      # Arrange
      # Ensure there is an existing driver saved
      # Assign the existing driver's id to a local variable
      # Set up the form data so that it violates Driver validations

      # Act-Assert
      # Ensure that there is no change in Driver.count

      # Assert
      # Check that the controller redirects

    end  end

  describe "destroy" do
    it "destroys the driver instance in db when driver exists, then redirects" do
      # Arrange
      # Ensure there is an existing driver saved

      # Act-Assert
      # Ensure that there is a change of -1 in Driver.count

      # Assert
      # Check that the controller redirects

    end

    it "does not change the db when the driver does not exist, then responds with " do
      # Arrange
      # Ensure there is an invalid id that points to no driver

      # Act-Assert
      # Ensure that there is no change in Driver.count

      # Assert
      # Check that the controller responds or redirects with whatever your group decides

    end
  end
end
