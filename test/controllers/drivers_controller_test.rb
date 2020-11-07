require "test_helper"

describe DriversController do
  # Note: If any of these tests have names that conflict with either the requirements or your team's decisions, feel empowered to change the test names. For example, if a given test name says "responds with 404" but your team's decision is to respond with redirect, please change the test name.
  let (:driver) {
    Driver.create name: "sample driver", vin: "ABC0000000000",
                  available: true
  }
  describe "index" do
    it "responds with success when there are many drivers saved" do
      # # Arrange
      # # Ensure that there is at least one Driver saved
      driver = Driver.new(name: "sample driver", vin: "ABC0000000000",
          available: true)
       driver.save
      # Act
      get drivers_path
      # Assert
      must_respond_with :success
    end

    it "responds with success when there are no drivers saved" do
      # Arrange
      # Ensure that there are zero drivers saved
      drivers = Driver.all
      expect(drivers).must_be_empty

      # Act
      get drivers_path

      # Assert
      must_respond_with :success
    end
  end

  describe "show" do
    it "responds with success when showing an existing valid driver" do
      # Arrange
      driver = Driver.new(name: "sample driver", vin: "ABC0000000000", available: true)
      # Ensure that there is a driver saved
      driver.save
      # Act
      get driver_path(driver.id)
      # Assert
      must_respond_with :success
    end

    it "responds with 404 with an invalid driver id" do
      # Arrange
      # Ensure that there is an id that points to no driver
      # Act
      get driver_path(-1)
      # Assert
      must_respond_with :not_found
    end
  end

  describe "new" do
    it "responds with success on a new driver page" do
      # Arrange
      # Act
      get new_driver_path
      # Assert
      must_respond_with :success
    end
  end

  describe "create" do
    it "can create a new driver with valid information accurately, and redirect to the driver's details page" do
      # Arrange
      # Set up the form data
      driver_hash = {
          driver: {
              name: "Michael Schumacher",
              vin: "QWERTY99189",
              available: true
          }
      }
      # Act-Assert
      # Ensure that there is a change of 1 in Driver.count
      expect {
        post drivers_path, params: driver_hash
      }.must_differ 'Driver.count', 1
      # Assert
      # Find the newly created Driver, and check that all its attributes match what was given in the form data
      # Check that the controller redirected the user
      new_driver = Driver.find_by(name:driver_hash[:driver][:name])
      must_redirect_to driver_path (new_driver.id)
      expect(new_driver.name).must_equal driver_hash[:driver][:name]
      expect(new_driver.vin).must_equal driver_hash[:driver][:vin]
      expect(new_driver.available).must_equal driver_hash[:driver][:available]
    end

    it "does not create a driver if the form data violates Driver validations, and responds with bad request" do
      # Note: This will not pass until ActiveRecord Validations lesson
      # Arrange
      # Set up the form data so that it violates Driver validations
      driver_hash = {
          driver: {
              name: nil,
              vin: nil,
              available: true
          }
      }
      # Act-Assert
      # Ensure that there is no change in Driver.count
      expect {
        post drivers_path, params: driver_hash
      }.must_differ 'Driver.count', 0
      # Assert
      # Check that the controller redirects

      must_respond_with :bad_request
    end
  end
  
  describe "edit" do
    it "responds with success when getting the edit page for an existing, valid driver" do
      # Arrange
      # Ensure there is an existing driver saved
      driver = Driver.create(name: "Michael Schumacher", vin: "QWERTY99189", available: true)
      driver.save
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
    before do
      Driver.create(name: "Michael Schumacher", vin: "QWERTY99189", available: true)
    end

    it "can update an existing driver with valid information accurately, and redirect" do
      # Arrange
      # Ensure there is an existing driver saved
      # Assign the existing driver's id to a local variable
      # Set up the form data
      updated_driver_hash = {
                driver: {
                    name: "Mika Hakkinen",
                    vin: "ZXCVBNM1645",
                    available: true
                }
            }

      driver = Driver.first

      # Act-Assert
      # Ensure that there is no change in Driver.count
      expect {
        patch driver_path(driver.id), params: updated_driver_hash
      }.wont_change 'Driver.count'

      # Assert
      # Use the local variable of an existing driver's id to find the driver again, and check that its attributes are updated
      # Check that the controller redirected the user
      must_redirect_to driver_path

      driver_id = driver.id
      driver = Driver.find_by(id: driver_id)
      expect(driver.name).must_equal updated_driver_hash[:driver][:name]
      expect(driver.vin).must_equal updated_driver_hash[:driver][:vin]
      expect(driver.available).must_equal updated_driver_hash[:driver][:available]
    end

    it "does not update any driver if given an invalid id, and responds with a 404" do
      # Arrange
      # Ensure there is an invalid id that points to no driver
      # Set up the form data
      invalid_driver_hash = {
          driver: {
              name: nil,
              vin: nil,
              available: nil
          }
      }
      # Act-Assert
      # Ensure that there is no change in Driver.count
      expect {
        patch driver_path(-1), params: invalid_driver_hash
      }.wont_change 'Driver.count'

      # Assert
      # Check that the controller gave back a 404
      must_respond_with :not_found
    end

    it "does not update a driver if the form data violates Driver validations, and responds with a bad request" do
      # Note: This will not pass until ActiveRecord Validations lesson
      # Arrange
      # Ensure there is an existing driver saved
      # Assign the existing driver's id to a local variable
      # Set up the form data so that it violates Driver validations

      invalid_driver_hash = {
          driver: {
              name: nil,
              vin: nil,
              available: nil
          }
      }
      driver = Driver.first
      # Act-Assert
      # Ensure that there is no change in Driver.count
      expect {
        patch driver_path(driver.id), params: invalid_driver_hash
      }.wont_change 'Driver.count'
      # Assert
      # Check that the controller redirects
      must_respond_with :bad_request
    end
  end

  describe "destroy" do
    it "destroys the driver instance in db when driver exists, then redirects" do
      # Arrange
      # Ensure there is an existing driver saved
      # driver_to_delete = Driver.new(name: "Michael Schumacher", vin: "QWERTY99189", available: true)
      # driver_to_delete.save
      #
      # id = driver_to_delete.id
      # # Act-Assert
      # # Ensure that there is a change of -1 in Driver.count
      # expect {
      #   delete driver_path(driver_to_delete.id), params: driver_to_delete
      #       }.must_differ 'Driver.count', -1
      #
      # # Assert
      # # Check that the controller redirects
      # driver_to_delete = Driver.find_by(id: id)
      #       expect(driver_to_delete).must_be_nil
      #       must_respond_with :redirect
      #       must_redirect_to drivers_path

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
