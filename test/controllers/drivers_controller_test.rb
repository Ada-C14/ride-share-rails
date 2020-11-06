require "test_helper"

describe DriversController do
  # Note: If any of these tests have names that conflict with either the requirements or your team's decisions, feel empowered to change the test names. For example, if a given test name says "responds with 404" but your team's decision is to respond with redirect, please change the test name.
  describe "index" do
    before do
      Driver.create(name: "India", vin: "9879", available: true)
    end

    it "responds with success when there are many drivers saved" do
      # Arrange
      # Ensure that there is at least one Driver saved
      # Act
      get "/drivers"
      # Assert
      must_respond_with :success
    end

    it "responds with success when there are no drivers saved" do
      # Arrange
      # Ensure that there are zero drivers saved
      Driver.delete_all
      # Act
      get "/drivers"
      # Assert
      must_respond_with :success
    end
  end

  describe "show" do
    
    let driver = Driver.create(name: "India", vin: "9879", available: true)

    it "responds with success when showing an existing valid driver" do
      # Arrange
      # Ensure that there is a driver saved
      id = driver.id
      # Act
      get "/drivers/#{id}"
      # Assert
      must_respond_with :success
    end

    it "responds with 404 with an invalid driver id" do
      # Arrange
      # Ensure that there is an id that points to no driver
      id = -1
      # Act
      get "/drivers/#{id}"
      # Assert
      must_respond_with :not_found
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
      driver_hash = {
        driver: {
          name: "India",
          vin: "9879",
          available: true
        }
      }
      # Arrange
      # Set up the form data
      # Act-Assert
      # Ensure that there is a change of 1 in Driver.count
      expect {
        post drivers_path, params: driver_hash
      }.must_differ "Driver.count", 1
      # Assert
      # Find the newly created Driver, and check that all its attributes match what was given in the form data
      # Check that the controller redirected the user
      expect(Driver.last.name).must_equal driver_hash[:driver][:name]
      expect(Driver.last.vin).must_equal driver_hash[:driver][:vin]
      expect(Driver.last.available).must_equal driver_hash[:driver][:available]
      must_redirect_to driver_path(Driver.last)
    end

    it "does not create a driver if the form data violates Driver validations, and responds with a redirect" do
      # Note: This will not pass until ActiveRecord Validations lesson
      # Arrange
      # Set up the form data so that it violates Driver validations
      driver_hash = {
        driver: {
          name: nil,
          vin: "9879",
          available: true
        }
      }
      # Act-Assert
      # Ensure that there is no change in Driver.count
      expect {
        post drivers_path, params: driver_hash
      }.must_differ "Driver.count", 0
      # Assert
      # Check that the controller redirects
      must_respond_with :redirect
    end
  end

  describe "edit" do
    it "responds with success when getting the edit page for an existing, valid driver" do
      # Arrange
      Driver.create(name: "India", vin: "9879", available: true)
      # Ensure there is an existing driver saved
      # Act
      get edit_driver_path(Driver.first.id)
      # Assert
      must_respond_with :success
    end

    it "responds with redirect when getting the edit page for a non-existing driver" do
      # Arrange
      # Ensure there is an invalid id that points to no driver
      id = -1
      # Act
      get edit_driver_path(id)
      # Assert
      must_respond_with :redirect
    end
  end

  describe "update" do
    
    let driver_hash = {
      driver: {
        name: "Emma",
        vin: "9090",
        available: true
      }
    }

    before do
      Driver.create(name: "India", vin: "9879", available: true)
    end

    it "can update an existing driver with valid information accurately, and redirect" do
      # Arrange
      # Ensure there is an existing driver saved
      # Assign the existing driver's id to a local variable
      # Set up the form data
      id = Driver.first.id
      # Act-Assert
      # Ensure that there is no change in Driver.count
      expect {
        patch driver_path(id), params: driver_hash
      }.wont_change "Driver.count"
      # Assert
      # Use the local variable of an existing driver's id to find the driver again, and check that its attributes are updated
      # Check that the controller redirected the user

    end

    it "does not update any driver if given an invalid id, and redirects to drivers_path" do
      # Arrange
      # Ensure there is an invalid id that points to no driver
      # Set up the form data
      # Act-Assert
      id = -1
      # Ensure that there is no change in Driver.count
      expect {
        patch driver_path(id), params: driver_hash
      }.wont_change "Driver.count"
      # Assert
      # Check that the controller redirects to drivers_path
      must_respond_with :redirect
    end

    it "does not create a driver if the form data violates Driver validations, and responds with a redirect" do
      # Note: This will not pass until ActiveRecord Validations lesson
      # Arrange
      # Ensure there is an existing driver saved
      # Assign the existing driver's id to a local variable
      # Set up the form data so that it violates Driver validations
      driver_hash[:driver][:name] = nil
      driver = Driver.first
      # Act-Assert
      # Ensure that there is no change in Driver.count
      expect {
        patch driver_path
      }
      # Assert
      # Check that the controller redirects

    end
  end

  describe "destroy" do
    it "destroys the driver instance in db when driver exists, then redirects" do
      # Arrange
      # Ensure there is an existing driver saved
      Driver.create(name: "India", vin: "9879", available: true)
      # Act-Assert
      # Ensure that there is a change of -1 in Driver.count
      expect {
        delete driver_path(Driver.first.id)
      }.must_change "Driver.count", -1
      # Assert
      # Check that the controller redirects
      must_respond_with :redirect
      must_redirect_to drivers_path
    end

    it "does not change the db when the driver does not exist, then responds with " do
      # Arrange
      # Ensure there is an invalid id that points to no driver
      id = -1
      # Act-Assert
      # Ensure that there is no change in Driver.count
      expect {
        delete driver_path(id)
      }.wont_change "Driver.count"
      # Assert
      # Check that the controller responds or redirects with whatever your group decides
      must_respond_with :not_found
    end
  end
end
