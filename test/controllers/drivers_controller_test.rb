require "test_helper"

describe DriversController do
  # Note: If any of these tests have names that conflict with either the requirements or your team's decisions, feel empowered to change the test names. For example, if a given test name says "responds with 404" but your team's decision is to respond with redirect, please change the test name.
  let(:fake_driver) {
    Driver.create(name: "Daisy Johnson", vin: "DKJF2K3F9834JKJ9", available: false)
  }

  describe "index" do
    it "responds with success when there are many drivers saved" do
      # Arrange
      # Ensure that there is at least one Driver saved
      driver1 = fake_driver
      driver2 = Driver.create(name: "Phil Coulson", vin: "EWRIU8934DFD34892", available: true)
      expect(Driver.count).wont_equal 0
      # Act
      get drivers_path

      # Assert
      must_respond_with :success
    end

    it "responds with success when there are no drivers saved" do
      # Arrange
      # Ensure that there are zero drivers saved
      expect(Driver.count).must_equal 0
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
      driver = fake_driver
      expect(driver.save).must_equal true
      # Act
      get driver_path(driver.id)
      # Assert
      must_respond_with :success

    end

    it "responds with 404 with an invalid driver id" do
      # Arrange
      # Ensure that there is an id that points to no driver
      invalid_id = -1

      # Act
      get driver_path(invalid_id)

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
      # Arrange
      # Set up the form data
      new_driver_hash = {
        driver: {
            name: "Neil Patrick Harris",
            vin: "DLKSEIV398349EIR",
            available: true
        }
      }
      # Act-Assert
      # Ensure that there is a change of 1 in Driver.count
      expect {
        post drivers_path, params: new_driver_hash
      }.must_differ "Driver.count", 1

      # Assert
      # Find the newly created Driver, and check that all its attributes match what was given in the form data
      # Check that the controller redirected the user
      new_driver = Driver.first
      expect(new_driver.name).must_equal new_driver_hash[:driver][:name]
      expect(new_driver.vin).must_equal new_driver_hash[:driver][:vin]
      expect(new_driver.available).must_equal new_driver_hash[:driver][:available]

      must_respond_with :redirect
      must_redirect_to drivers_path
    end

    it "does not create a driver if the form data violates Driver validations, and responds with a redirect" do
      # Note: This will not pass until ActiveRecord Validations lesson
      # Arrange
      # Set up the form data so that it violates Driver validations
      invalid_input = {
        driver: {
          name: 934838,
          vin: "skdjfdkfjdk938439",
          available: true
        }
      }

      # Act-Assert
      # Ensure that there is no change in Driver.count
      expect {
        post drivers_path, params: invalid_input
      }.wont_change "Driver.count"

      # Assert
      # Check that the controller redirects
      # todo: update after validation lesson
      must_respond_to :redirect

    end
  end
  
  describe "edit" do
    it "responds with success when getting the edit page for an existing, valid driver" do
      # Arrange
      # Ensure there is an existing driver saved
      driver = fake_driver
      # Act
      get edit_driver_path(driver.id)
      # Assert
      must_respond_with :success
    end

    it "responds with not_found when getting the edit page for a non-existing driver" do
      # Arrange
      # Ensure there is an invalid id that points to no driver
      invalid_id = -1
      # Act
      get edit_driver_path(invalid_id)
      # Assert
      must_respond_with :not_found
    end
  end

  describe "update" do
    before do
      @update_info = {
          driver: {
              name: "Skye Johnson",
              vin: "DKJF2K3F9834JKJ9",
              available: true
          }
      }
    end
    it "can update an existing driver with valid information accurately, and redirect" do
      # Arrange
      # Ensure there is an existing driver saved
      driver = fake_driver
      # Assign the existing driver's id to a local variable
      valid_id = driver
      # Set up the form data


      # Act-Assert
      # Ensure that there is no change in Driver.count
      expect {
        patch driver_path(valid_id), params: @update_info
      }.wont_change "Driver.count"

      # Assert
      # Use the local variable of an existing driver's id to find the driver again, and check that its attributes are updated
      updated_driver = Driver.find(driver.id)
      expect(updated_driver.name).must_equal @update_info[:driver][:name]
      expect(updated_driver.vin).must_equal @update_info[:driver][:vin]
      expect(updated_driver.available).must_equal @update_info[:driver][:available]
      # Check that the controller redirected the user
      must_respond_with :redirect
      must_redirect_to drivers_path

    end

    it "does not update any driver if given an invalid id, and responds with a 404" do
      # Arrange
      # Ensure there is an invalid id that points to no driver
      invalid_id = -1

      # Act-Assert
      # Ensure that there is no change in Driver.count
      expect {
        patch driver_path(invalid_id), params: @update_info
      }.wont_change "Driver.count"

      # Assert
      # Check that the controller gave back a 404
      must_respond_with :not_found
    end

    it "does not create a driver if the form data violates Driver validations, and responds with a redirect" do
      # Note: This will not pass until ActiveRecord Validations lesson
      # Arrange
      # Ensure there is an existing driver saved
      driver = fake_driver
      # Assign the existing driver's id to a local variable
      valid_id = driver.id
      # Set up the form data so that it violates Driver validations
      invalid_input = {
          driver: {
              name: 934838,
              vin: "skdjfdkfjdk938439",
              available: true
          }
      }

      # Act-Assert
      # Ensure that there is no change in Driver.count
      expect {
        patch driver_path(valid_id), params: invalid_input
      }.wont_change "Driver.count"

      # Assert
      # Check that the controller redirects
      # todo: update after validation lesson
      must_respond_with :redirect

    end
  end

  describe "destroy" do
    it "destroys the driver instance in db when driver exists, then redirects" do
      # Arrange
      # Ensure there is an existing driver saved
      driver = fake_driver

      # Act-Assert
      # Ensure that there is a change of -1 in Driver.count
      expect {
        delete driver_path(driver.id)
      }.must_differ "Driver.count", -1

      # Assert
      # Check that the controller redirects
      must_respond_with :redirect
      must_redirect_to drivers_path

    end

    it "does not change the db when the driver does not exist, then responds with " do
      # Arrange
      # Ensure there is an invalid id that points to no driver
      invalid_id = -1
      # Act-Assert
      # Ensure that there is no change in Driver.count
      expect {
        delete driver_path(invalid_id)
      }.wont_change "Driver.count"

      # Assert
      # Check that the controller responds or redirects with whatever your group decides
      must_respond_with :not_found

    end
  end
end
