require "test_helper"

describe DriversController do

  # Note: If any of these tests have names that conflict with either the requirements or your team's decisions, feel empowered to change the test names. For example, if a given test name says "responds with 404" but your team's decision is to respond with redirect, please change the test name.

  describe "index" do
    it "responds with success when there are many drivers saved" do
      driver = Driver.create(
          name: "Jane Do",
          vin: "3999877uu",
          available: false
      )
      expect(Driver.count).must_equal 1
      get drivers_path
      must_respond_with :success
    end

    it "responds with success when there are no drivers saved" do
      expect(Driver.count).must_equal 0
      get drivers_path
      must_respond_with :success

    end
  end

  describe "show" do
    it "responds with success when showing an existing valid driver" do
      driver = Driver.create(
          name: "Jane Do",
          vin: "3999877uu",
          available: false
      )

      get driver_path(driver.id)
      must_respond_with :success

    end

    it "must redirect with an invalid driver id" do
      get driver_path(-1)
      must_respond_with :redirect
    end
  end

  describe "new" do
    it "responds with success" do
    end
  end

  describe "create" do
    it "can create a new driver with valid information accurately, and redirect" do
      # Arrange
      driver_hash = {
          driver: {
              name: "John Do",
              vin: "ww234444",
              available: false
          },
      }
      # Act-Assert
      # Ensure that there is a change of 1 in Driver.count
      expect {
        post drivers_path, params: driver_hash
      }.must_change "Driver.count", 1

      # Assert
      # Find the newly created Driver, and check that all its attributes match what was given in the form data
      new_driver = Driver.find_by(name: driver_hash[:driver][:name])
      expect(new_driver.vin).must_equal driver_hash[:driver][:vin]
      expect(new_driver.available).must_equal driver_hash[:driver][:available]

      # Check that the controller redirected the user
      must_respond_with :redirect
      must_redirect_to driver_path(new_driver.id)

    end

    it "does not create a driver if the form data violates Driver validations, and responds with a redirect" do
      # Note: This will not pass until ActiveRecord Validations lesson
      # Arrange
      # Set up the form data so that it violates Driver validations

      # Act-Assert
      # Ensure that there is no change in Driver.count

      # Assert
      # Check that the controller redirects

    end
  end

  describe "edit" do
    it "responds with success when getting the edit page for an existing, valid driver" do
      # Arrange
      driver = Driver.create(
        name: "Jane Do",
        vin: "3999877uu",
        available: false
      )
      # Ensure there is an existing driver saved
      get edit_driver_path(driver.id)
      # Act/Assert
      must_respond_with :success
    end

    it "responds with redirect when getting the edit page for a non-existing driver" do
      # Arrange
      # Ensure there is an invalid id that points to no driver
      get edit_driver_path(-1)
      # Act/ssert
      must_respond_with :redirect

    end
  end

  describe "update" do
    before do
      Driver.create(
        name: "Jane Doe",
        vin: "89979Ui99",
        available: true )
    end

    let (:update_driver_hash) do {
        driver:{
            name: "John Doe",
            vin: "9990220T",
            available: false
        }
    }
    end
    
    it "can update an existing driver with valid information accurately, and redirect" do
      driver_id = Driver.first.id
      expect {
        patch driver_path(driver_id), params: update_driver_hash
      }.wont_change "Driver.count"

      must_respond_with :redirect

      driver = Driver.find_by(id: driver_id)
      expect(driver.name).must_equal update_driver_hash[:driver][:name]
      expect(driver.vin).must_equal update_driver_hash[:driver][:vin]
      expect(driver.available).must_equal update_driver_hash[:driver][:available]

    end

    it "does not update any driver if given an invalid id, and redirect to drivers path" do
      # Arrange
      # Ensure there is an invalid id that points to no driver
      # Set up the form data
      # Act-Assert
      # Ensure that there is no change in Driver.count
      # Assert
      # Check that the controller gave back a 404

      expect {
        get edit_driver_path(-1), params: update_driver_hash
      }.wont_change "Driver.count"
      must_redirect_to drivers_path

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
    before do
      Driver.create(
          name: "Jane Doe",
          vin: "89979Ui99",
          available: true )
    end
    it "destroys the driver instance in db when driver exists, then redirects" do
      # Arrange
      id = Driver.first.id

      # Act-Assert
      # Ensure that there is a change of -1 in Driver.count
      expect {
        delete driver_path(id)
      }.must_change 'Driver.count', -1

      # Assert
      # Check that the controller redirects
      driver = Driver.find_by(name: "Cry in Bed")

      expect(driver).must_be_nil

      must_respond_with :redirect
      must_redirect_to drivers_path

    end

    it "does not change the db when the driver does not exist, then responds with " do

      delete driver_path(-1)
      must_redirect_to driver_path

    end
  end
end
