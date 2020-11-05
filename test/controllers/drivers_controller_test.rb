require "test_helper"

describe DriversController do
  # Note: If any of these tests have names that conflict with either the requirements or your team's decisions, feel empowered to change the test names. For example, if a given test name says "responds with 404" but your team's decision is to respond with redirect, please change the test name.

  let (:driver) {
    Driver.create(name: "Shane Doe", vin: "HKJS12345HJGS", availability_status: true)
  }

  describe "index" do
    it "responds with success when there are many drivers saved" do
      # Arrange
      # Ensure that there is at least one Driver saved
      d = driver
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
      d = driver
      # Act
      get driver_path(d.id)
      # Assert
      must_respond_with :success

    end

    it "responds with 404 with an invalid driver id" do
      # Arrange
      # Ensure that there is an id that points to no driver

      # Act
      get driver_path(100)
      # Assert
      must_respond_with :not_found
    end
  end

  describe "new" do
    it "responds with success" do

      # Act
      get new_driver_path

      # Assert
      must_respond_with :success
    end
  end

  describe "create" do
    it "when new driver is created, availability status is true" do

      driver_hash = {
          driver: {
              name: "Sally Sombody",
              vin: "HKJHSIU3467854",
          }
      }

      post drivers_path, params: driver_hash

      d = Driver.last

      expect(d.availability_status).must_equal true

    end

    it "can create a new driver with valid information accurately, and redirect" do
      # Arrange
      # Set up the form data
      driver_hash = {
          driver: {
              name: "Sally Sombody",
              vin: "HKJHSIU3467854",
          }
      }
      # Act-Assert
      # Ensure that there is a change of 1 in Driver.count
      expect {
        post drivers_path, params: driver_hash
      }. must_differ "Driver.count", 1

      # Assert
      # Find the newly created Driver, and check that all its attributes match what was given in the form data
      # Check that the controller redirected the user


      new_driver = Driver.last

      expect(new_driver.name).must_equal driver_hash[:driver][:name]
      expect(new_driver.vin).must_equal driver_hash[:driver][:vin]
      expect(new_driver.availability_status).must_equal true

      must_respond_with :redirect
      must_redirect_to driver_path(new_driver.id)
    end

    it "does not create a driver if the form data violates Driver validations, and responds with a redirect" do
      # Note: This will not pass until ActiveRecord Validations lesson
      # Arrange
      # Set up the form data so that it violates Driver validations
      invalid_driver_hash = {
          driver: {
              name: "Name only"
          }
      }

      # Act-Assert
      # Ensure that there is no change in Driver.count
      expect{
        post drivers_path, params: invalid_driver_hash
      }.wont_change "Driver.count"

      # Assert
      # Check that the controller redirects
      must_respond_with :success
    end
  end

  before do
    Driver.create(name: "Anna Bobby", vin: "BFJHD2345654", availability_status: true)
  end
  let(:new_driver) {
    {
        driver: {
            name: "Sarah Copper",
            vin: "CKJEU3245765KJBK",
            availability_status: true,
        },
    }
  }

  describe "edit" do
    it "responds with success and redirect when getting the edit page for an existing, valid driver" do
      # Arrange
      # Ensure there is an existing driver saved
      driver = Driver.find_by(name: "Anna Bobby")
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
      must_respond_with :not_found

    end
  end

  describe "update" do
    it "can update an existing driver with valid information accurately, and redirect" do
      # Arrange
      # Ensure there is an existing driver saved
      # Assign the existing driver's id to a local variable
      # Set up the form data

      found_driver = Driver.find_by(name: "Anna Bobby")

      # Act-Assert
      # Ensure that there is no change in Driver.count

      expect{
        patch driver_path(found_driver.id), params: new_driver
      }. wont_change "Driver.count"

      must_redirect_to driver_path(found_driver.id)

      # Assert
      # Use the local variable of an existing driver's id to find the driver again, and check that its attributes are updated
      # Check that the controller redirected the user

      found_driver.reload
      expect(found_driver.name).must_equal new_driver[:driver][:name]
      expect(found_driver.vin).must_equal new_driver[:driver][:vin]
      expect(found_driver.availability_status).must_equal new_driver[:driver][:availability_status]

    end

    it "does not update any driver if given an invalid id, and responds with a 404" do
      # Arrange
      # Ensure there is an invalid id that points to no driver
      # Set up the form data

      # Act-Assert
      # Ensure that there is no change in Driver.count
      expect{
        patch driver_path(-1), params: new_driver
      }. wont_change "Driver.count"

      # Assert
      # Check that the controller gave back a 404
      must_respond_with :not_found
    end

    it "does not create a driver if the form data violates Driver validations, and responds with a redirect" do
      # Note: This will not pass until ActiveRecord Validations lesson
      # Arrange
      # Ensure there is an existing driver saved
      # Assign the existing driver's id to a local variable

      found_driver = Driver.find_by(name: "Anna Bobby")

      # Set up the form data so that it violates Driver validations

      invalid_driver_hash = {
        driver: {
            vin: "Vin only"
        }
      }

      # Act-Assert
      # Ensure that there is no change in Driver.count
      expect{
        patch driver_path(found_driver.id), params: invalid_driver_hash
      }.wont_change "Driver.count"

      # Assert
      # Check that the controller redirect
      must_respond_with :redirect
      must_redirect_to driver_path(found_driver.id)

      #check to make sure attempted save with invalid params did not overwrite previously saved object
      refound_driver = Driver.find_by(name: "Anna Bobby")
      expect(refound_driver).must_equal found_driver
    end
  end

  describe "destroy" do
    it "destroys the driver instance in db when driver exists, then redirects" do
      # Arrange
      # Ensure there is an existing driver saved
      driver_to_delete = Driver.find_by(name: "Anna Bobby")
      # Act-Assert
      # Ensure that there is a change of -1 in Driver.count
      expect {
        delete driver_path(driver_to_delete.id)
      }.must_differ "Driver.count", -1
      # Assert
      # Check that the controller redirects

      driver_to_delete = Driver.find_by(name: "Anna Bobby")

      expect(driver_to_delete).must_be_nil

      must_redirect_to drivers_path

    end

    it "does not change the db when the driver does not exist, then responds with " do
      # Arrange
      # Ensure there is an invalid id that points to no driver

      # Act-Assert
      # Ensure that there is no change in Driver.count
      expect{
        delete driver_path(-1)
      }.wont_change "Driver.count"
      # Assert
      # Check that the controller responds or redirects with whatever your group decides

      must_respond_with :not_found
    end
  end
end
