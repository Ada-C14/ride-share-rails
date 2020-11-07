require "test_helper"

describe DriversController do
  # Note: If any of these tests have names that conflict with either the requirements or your team's decisions, feel empowered to change the test names. For example, if a given test name says "responds with 404" but your team's decision is to respond with redirect, please change the test name.
  let(:driver) {
    Driver.create name: "driver name", vin: "vin number", available: true
  }
  describe "index" do
    it "responds with success when there are many drivers saved" do #PASSING
      # Arrange
      get drivers_path
      # Ensure that there is at least one Driver saved
      # Act
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
    it "responds with success when showing an existing valid driver" do #PASSING
      # Arrange
      get driver_path(driver.id)
      # Ensure that there is a driver saved
      must_respond_with :success
      # Act
      # Assert
    end

    it "responds with 404 with an invalid driver id" do  #PASSING
      # Arrange
      # Ensure that there is an id that points to no driver
      get driver_path(-12)
      # Act
      must_respond_with :not_found
      # Assert
    end
  end

  describe "new" do

    it "responds with success" do
    end
  end

  describe "create" do
    it "can create a new driver with valid information accurately, and redirect" do #PASSING
      # Arrange
      # Set up the form data
      new_driver_hash = {
          driver:{
              name: "new driver name",
              vin: "driver vin info",
              available: true,
          }
      }
      # Act-Assert
      # Ensure that there is a change of 1 in Driver.count
      expect {
        post drivers_path, params: new_driver_hash
      }.must_change "Driver.count", 1
      # Assert
      # Find the newly created Driver, and check that all its attributes match what was given in the form data
      # Check that the controller redirected the user
      new_driver = Driver.find_by(name:new_driver_hash[:driver][:name])
      expect(new_driver.vin).must_equal new_driver_hash[:driver][:vin]
      # expect(new_driver.available).must_equal true

      must_respond_with :redirect
      must_redirect_to driver_path(new_driver.id)
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
      get edit_driver_path(driver.id)
      # Act
      must_respond_with :success
      # Assert

    end

    it "responds with redirect when getting the edit page for a non-existing driver" do  #PASSING
      # Arrange
      # Ensure there is an invalid id that points to no driver
      get edit_driver_path(-10)

      # Act
      must_respond_with :redirect
      must_redirect_to drivers_path
      # Assert

    end
  end

  describe "update" do
    it "can update an existing driver with valid information accurately, and redirect" do  #PASSING
      # Arrange
      # Ensure there is an existing driver saved'

      driver_hash = {
          driver:{
              name: "new driver name",
              vin: "driver vin info",
              available: true,
          }
      }
      # Assign the existing driver's id to a local variable
      # Set up the form data
      expect {
        post drivers_path, params: driver_hash
      }.must_change "Driver.count", 1
      # Act-Assert
      # Ensure that there is no change in Driver.count
      new_driver = Driver.find_by(name:driver_hash[:driver][:name])
      expect(new_driver.vin).must_equal driver_hash[:driver][:vin]
      # Assert
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

    end
  end

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
