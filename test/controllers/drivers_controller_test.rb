require "test_helper"

describe DriversController do
  # Note: If any of these tests have names that conflict with either the requirements or your team's decisions, feel empowered to change the test names. For example, if a given test name says "responds with 404" but your team's decision is to respond with redirect, please change the test name.

  let (:driver) {
    Driver.create name: "Driver",
                  vin: "WBWSS52P9NEYLVDE9",
                  available: 'true'
  }

  let (:driver_hash) {
    {
        driver: {
            name: "New Driver",
            vin: "XBWSS52P9NEYLVDE9",
            available: "true"
        }
    }
  }

  let (:invalid_driver_hash) {
    {
        driver: {
            name: nil,
            vin: "XBWSS52P9NEYLVDE9",
            available: "true"
        }
    }
  }

  describe "index" do
    it "responds with success when there are many drivers saved" do
      # Arrange
      # Ensure that there is at least one Driver saved
      # instantiate driver from let block
      driver

      # Act
      get drivers_path

      # Assert
      must_respond_with :success
    end

    it "responds with success when there are no drivers saved" do
      # Arrange
      # Ensure that there are zero drivers saved

      # Act
      get drivers_path

      # Assert
      must_respond_with :success
    end
  end

  describe "show" do
    it "responds with success when showing an existing valid driver" do
      # Arrange
      # Ensure that there is a driver saved
      # instantiate driver from let block
      driver

      # Act
      get driver_path(driver.id)
      # Assert
      must_respond_with :success
    end

    it "will redirect when passed an invalid driver id" do
      # Arrange
      # Ensure that there is an id that points to no driver

      # Act
      get driver_path(-1)
      # Assert
      must_respond_with :redirect
    end
  end

  describe "new" do
    it "responds with success" do
      get new_driver_path
      must_respond_with :success
    end
  end

  describe "create" do
    it "can create a new driver with valid information accurately, and redirect" do
      # Arrange
      # Set up the form data

      # Act-Assert
      # Ensure that there is a change of 1 in Driver.count
      expect {
        post drivers_path, params: driver_hash
      }.must_change "Driver.count", 1
      
      # Assert
      # Find the newly created Driver, and check that all its attributes match what was given in the form data
      # Check that the controller redirected the user
      new_driver = Driver.find_by(name: driver_hash[:driver][:name])
      expect(new_driver.vin).must_equal driver_hash[:driver][:vin]
      expect(new_driver.available).must_equal driver_hash[:driver][:available]

      must_respond_with :redirect
      must_redirect_to driver_path(new_driver.id)
    end

    it "does not create a driver if the form data violates Driver validations" do
      # Note: This will not pass until ActiveRecord Validations lesson
      # Arrange
      # Set up the form data so that it violates Driver validations
      driver
      # Act-Assert
      # Ensure that there is no change in Driver.count
      expect {
        post drivers_path, params: invalid_driver_hash
      }.wont_change "Driver.count"

      # render new instead of redirect, so not testing for that
    end
  end

  describe "edit" do
    it "responds with success when getting the edit page for an existing, valid driver" do
      # Arrange
      # Ensure there is an existing driver saved

      # Act
      get edit_driver_path(driver.id)
      # Assert
      must_respond_with :success
    end

    it "responds with redirect when getting the edit page for a non-existing driver" do
      # Arrange
      # Ensure there is an invalid id that points to no driver

      # Act
      get edit_driver_path(-1)
      # Assert
      must_respond_with :redirect
    end
  end

  describe "update" do

    before do
      Driver.create(name: "Driver", vin: "WBWSS52P9NEYLVDE9")
    end
    
    it "can update an existing driver with valid information accurately, and redirect" do
      # Arrange
      # Ensure there is an existing driver saved
      # Assign the existing driver's id to a local variable
      # Set up the form data
      driver = Driver.first
      
      # Act-Assert
      # Ensure that there is no change in Driver.count
      expect {
        patch driver_path(driver.id), params: driver_hash
      }.wont_change 'Driver.count'
      
      # Assert
      # Use the local variable of an existing driver's id to find the driver again, and check that its attributes are updated
      # Check that the controller redirected the user
      driver.reload

      expect(driver.name).must_equal driver_hash[:driver][:name]
      expect(driver.vin).must_equal driver_hash[:driver][:vin]
      expect(driver.available).must_equal driver_hash[:driver][:available]

      must_respond_with :redirect
      must_redirect_to driver_path(driver.id)
    end

    it "does not update any driver if given an invalid id and redirects" do
      # Arrange
      # Ensure there is an invalid id that points to no driver
      # Set up the form data

      # Act-Assert
      # Ensure that there is no change in Driver.count
      expect {
        patch driver_path(-1), params: driver_hash
      }.wont_change 'Driver.count'

      # Assert
      must_respond_with :redirect
    end

    it "does not patch a driver if the form data violates Driver validations" do
      # Note: This will not pass until ActiveRecord Validations lesson
      # Arrange
      # Ensure there is an existing driver saved
      # Assign the existing driver's id to a local variable
      # Set up the form data so that it violates Driver validations
      original_name = driver.name
      original_vin = driver.vin
      original_available = driver.available

      # Act-Assert
      # Ensure that there is no change in Driver.count
      expect {
        patch driver_path(driver.id), params: invalid_driver_hash
      }.wont_change "Driver.count"

      driver.reload

      expect(driver.name).must_equal original_name
      expect(driver.vin).must_equal original_vin
      expect(driver.available).must_equal original_available

      # render new instead of redirect, so not testing for that
    end
  end

  describe "destroy" do
    it "destroys the driver instance in db when driver exists, then redirects" do
      # Arrange
      # Ensure there is an existing driver saved
      driver
      # Act-Assert
      # Ensure that there is a change of -1 in Driver.count
      expect {
        delete driver_path(driver.id)
      }.must_change 'Driver.count', -1
      # Assert
      # Check that the controller redirects
      must_respond_with :redirect
    end

    it "does not change the db when the driver does not exist, then redirects" do
      # Arrange
      # Ensure there is an invalid id that points to no driver

      # Act-Assert
      # Ensure that there is no change in Driver.count
      expect {
        delete driver_path(-1)
      }.wont_change 'Driver.count'
      # Assert
      # Check that the controller responds or redirects with whatever your group decides
      must_respond_with :redirect
    end
  end
end
