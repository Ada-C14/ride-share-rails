require "test_helper"

describe DriversController do
  # Note: If any of these tests have names that conflict with either the requirements or your team's decisions, feel empowered to change the test names. For example, if a given test name says "responds with 404" but your team's decision is to respond with redirect, please change the test name.

  # TODO RINGO delete this later
  # There is a helper method for each HTTP verb,
  # and each helper method takes the path as an argument.
  # Every controller test we write will call
  # at least one of these helper methods

  describe "index" do
    it "responds with success when there are many drivers saved" do
      # Arrange
      # Ensure that there is at least one Driver saved
      new_driver = Driver.new(name: "Hedy Lamarr", vin: "1234567890abcdefg", available: true)
      new_driver.save

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
      new_driver = Driver.new(name: "Hedy Lamarr", vin: "1234567890abcdefg", available: true)
      new_driver.save
      driver_id = new_driver.id

      # Act
      get driver_path(driver_id)

      # Assert
      must_respond_with :success
    end

    it "redirects for an invalid driver id" do
      # Arrange
      # Ensure that there is an id that points to no driver
      invalid_id = -1

      # Act
      get driver_path(invalid_id)

      # Assert
      must_respond_with :redirect
    end
  end

  describe "new" do
    it "responds with success" do
      get new_book_path

      must_respond_with :success
    end
  end

  describe "create" do
    it "can create a new driver with valid information accurately, and redirect" do
      # Arrange
      # Set up the form data
      valid_driver = {
          driver: {
              name: "Clara Bow",
              vin: "SKDO2938GHEK29385",
              available: false
          }
      }

      # Act-Assert
      # Ensure that there is a change of 1 in Driver.count
      expect {
        post drivers_path, params: valid_driver
      }.must_differ "Driver.count", 1

      # Assert
      # Find the newly created Driver, and check that all its attributes match what was given in the form data
      # Check that the controller redirected the user
      saved_driver = Driver.find_by(name: valid_driver[:driver][:name])

      expect(saved_driver.name).must_equal valid_driver[:driver][:name]
      expect(saved_driver.vin).must_equal valid_driver[:driver][:vin]
      expect(saved_driver.available).must_equal valid_driver[:driver][:vin]
    end

    it "does not create a driver if the form data violates Driver validations, and responds with a redirect" do
      # Note: This will not pass until ActiveRecord Validations lesson
      # Arrange
      # Set up the form data so that it violates Driver validations
      invalid_driver = {
          driver: {
              name: "",
              vin: "123",
              available: "false"
          }
      }

      # Act-Assert
      # Ensure that there is no change in Driver.count
      expect {
        post drivers_path, params: invalid_driver
      }.wont_change Driver.count

      # Assert
      # Check that the controller redirects
      must_respond_with :redirect
    end
  end
  
  describe "edit" do
    it "responds with success when getting the edit page for an existing, valid driver" do
      # Arrange
      # Ensure there is an existing driver saved
      new_driver = Driver.new(name: "Hedy Lamarr", vin: "1234567890abcdefg", available: true)
      new_driver.save
      driver_id = new_driver.id

      # Act
      get driver_path(driver_id)

      # Assert
      must_respond_with :success
    end

    it "responds with redirect when getting the edit page for a non-existing driver" do
      # Arrange
      # Ensure there is an invalid id that points to no driver
      driver_id = (-1)

      # Act
      get driver_path(driver_id)

      # Assert
      must_respond_with :redirect
    end
  end

  describe "update" do
    it "can update an existing driver with valid information accurately, and redirect" do
      # Arrange
      # Ensure there is an existing driver saved
      # Assign the existing driver's id to a local variable
      # Set up the form data
      new_driver = Driver.new(name: "Hedy Lamarr", vin: "1234567890abcdefg", available: true)
      new_driver.save
      new_driver.reload
      driver_id = new_driver.id
      new_info = {
          driver: {
              name: "Lillian Gish",
              vin: "GFEDCBA0987654321",
              available: false
          }
      }
      # Act-Assert
      # Ensure that there is no change in Driver.count
      expect {
        patch driver_path(driver_id), params: new_info
      }.wont_change Driver.count

      # Assert
      # Use the local variable of an existing driver's id to find the driver again, and check that its attributes are updated
      # Check that the controller redirected the user
      updated_driver = Driver.find_by(driver_id)

      expect(updated_driver.name).must_equal new_info[:driver][:name]
      expect(updated_driver.vin).must_equal new_info[:driver][:vin]
      expect(updated_driver.available).must_equal new_info[:driver][:available]

      must_respond_with :redirect
    end

    it "does not update any driver if given an invalid id, and redirects" do
      # Arrange
      # Ensure there is an invalid id that points to no driver
      # Set up the form data
      driver_id = -1
      new_info = {
          driver: {
              name: "Lillian Gish",
              vin: "GFEDCBA0987654321",
              available: false
          }
      }

      # Act-Assert
      # Ensure that there is no change in Driver.count
      expect {
        patch driver_path(driver_id), params: new_info
      }.wont_change Driver.count

      # Assert
      # Check that the controller redirected
      must_respond_with :redirect
    end

    it "does not create a driver if the form data violates Driver validations, and responds with a redirect" do
      # Note: This will not pass until ActiveRecord Validations lesson
      # Arrange
      # Ensure there is an existing driver saved
      # Assign the existing driver's id to a local variable
      # Set up the form data so that it violates Driver validations
      new_driver = Driver.new(name: "Hedy Lamarr", vin: "1234567890abcdefg", available: true)
      new_driver.save
      new_driver.reload
      driver_id = new_driver.id
      bad_info = {
          driver: {
              name: "",
              vin: "GFED",
              available: "yes"
          }
      }

      # Act-Assert
      # Ensure that there is no change in Driver.count
      expect {
        patch driver_path(driver_id), params: bad_info
      }.wont_change Driver.count

      # Assert
      # Check that the controller redirects
      must_respond_with :redirect
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
