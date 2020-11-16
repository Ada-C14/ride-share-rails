require "test_helper"

describe DriversController do
  before(:all) do
    @test_driver = Driver.create(name:"C14", vin: "12345678901234567", available: true)
  end

  describe "index" do
    it "responds with success when there are many drivers saved" do
      # Arrange
      @test_driver

      # Act
      get drivers_path

      # Assert
      must_respond_with :success
    end

    it "responds with success when there are no drivers saved" do
      # Arrange
      Driver.destroy_all

      # Act
      get drivers_path

      # Assert
      must_respond_with :success
    end
  end

  describe "show" do
    it "responds with success when showing an existing valid drivers" do
      # Arrange
      @test_driver

      # Act
      get driver_path(@test_driver.id)

      # Assert
      must_respond_with :success

    end

    it "responds with redirect for an invalid drivers id" do
      # Arrange-Act
      get driver_path(-1)

      # Assert
      must_respond_with :redirect
      must_redirect_to drivers_path
    end
  end

  describe "new" do
    it "responds with success" do
      get new_driver_path
      must_respond_with :success
    end
  end

  describe "create" do
    it "can create a new drivers with valid information accurately, and redirect" do
      # Arrange
      # Set up the form data
      driver_hash = {
        driver: {
          name: "newbie",
          vin: "ABC123ABC123ABC12"
        }
      }

      # Act-Assert
      # Ensure that there is a change of 1 in Driver.count
      expect {
        post drivers_path, params: driver_hash
      }.must_change "Driver.count", 1
      # Assert
      # Find the newly created Driver, and check that all its attributes match what was given in the form data
      # Check that the controller redirected the user

      new_driver = Driver.find_by(name: driver_hash[:driver][:name])

      expect(new_driver.name).must_equal driver_hash[:driver][:name]
      expect(new_driver.vin).must_equal driver_hash[:driver][:vin]
      expect(new_driver.available).must_equal true


      must_redirect_to driver_path(new_driver)

    end

    it "does not create a driver if the form data violates Driver validations, and responds with a redirect" do
      # Note: This will not pass until ActiveRecord Validations lesson
      # Arrange
      # Set up the form data so that it violates Driver validations

      driver_hash = {
              driver: {
                name: nil,
                vin: "ABC"
              }
            }

      # Act-Assert
      # Ensure that there is no change in Driver.count
      expect {
        post drivers_path, params: driver_hash
      }.wont_change "Driver.count"

      # Assert
      # Check that the controller redirects
      must_respond_with :success

    end
  end
  
  describe "edit" do
    it "responds with success when getting the edit page for an existing, valid drivers" do
      # Arrange-Act
      get edit_driver_path(@test_driver.id)
      # Assert
      must_respond_with :success
    end

    it "responds with redirect when getting the edit page for a non-existing drivers" do
      # Arrange-Act
      get edit_driver_path(-1)

      # Assert
      must_redirect_to drivers_path
    end
  end

  describe "update" do
    it "can update an existing driver with valid information accurately, and redirect" do
      # Arrange
      # Ensure there is an existing drivers saved
      # Assign the existing drivers's id to a local variable
      test_id = Driver.first.id
      # Set up the form data
      driver_hash = {
        driver: {
          name: "new name",
          vin: "qwertyuiopzxcvbnm",
          available: false
        }
      }

      # Act-Assert
      # Ensure that there is no change in Driver.count
      expect {
        patch driver_path(test_id), params: driver_hash
      }.wont_change "Driver.count"

      # Assert
      # Use the local variable of an existing drivers's id to find the drivers again, and check that its attributes are updated
      updated_driver = Driver.find_by(id: test_id)
      expect(updated_driver.name).must_equal driver_hash[:driver][:name]
      expect(updated_driver.vin).must_equal driver_hash[:driver][:vin]
      expect(updated_driver.available).must_equal driver_hash[:driver][:available]

      # Check that the controller redirected the user
      must_redirect_to driver_path


    end

    it "does not update any drivers if given an invalid id, and responds with a redirect" do
      # Arrange
      # Ensure there is an invalid id that points to no drivers
      test_id = -1
      # Set up the form data
      driver_hash = {
        driver: {
          name: nil,
          vin: "qwerty",
          available: nil
        }
      }

      # Act-Assert
      # Ensure that there is no change in Driver.count
      expect {
        patch driver_path(test_id), params: driver_hash
      }.wont_change "Driver.count"

      # Assert

      must_redirect_to drivers_path

    end


    it "does not create a drivers if the form data violates Driver validations, and responds with a redirect" do
      # Note: This will not pass until ActiveRecord Validations lesson
      # Arrange
      # Ensure there is an existing drivers saved
      test_id = Driver.first.id
      # Assign the existing drivers's id to a local variable
      # Set up the form data so that it violates Driver validations
      driver_hash = {
        driver: {
          name: nil,
          vin: "qwerty",
          available: nil
        }
      }
      # Act-Assert
      # Ensure that there is no change in Driver.count
      expect {
        patch driver_path(test_id), params: driver_hash
      }.wont_change "Driver.count"

      # Assert
      updated_driver = Driver.find_by(id: test_id)
      expect(updated_driver.name).must_equal Driver.first.name
      expect(updated_driver.vin).must_equal Driver.first.vin
      expect(updated_driver.available).must_equal Driver.first.available
      # Check that the controller redirects
      must_respond_with :success
    end
  end

  describe "destroy" do
    it "destroys the drivers instance in db when drivers exists, then redirects" do
      # Arrange
      # Ensure there is an existing drivers saved
      test_id = Driver.first.id

      # Act-Assert
      # Ensure that there is a change of -1 in Driver.count
      expect {
        delete driver_path(test_id)
      }.must_change "Driver.count", -1

      # Assert
      # Check that the controller redirects
      must_redirect_to drivers_path

    end

    it "does not change the db when the drivers does not exist, then responds with redirect" do
      # Arrange
      # Ensure there is an invalid id that points to no drivers

      # Act-Assert
      # Ensure that there is no change in Driver.count
      expect {
        delete driver_path(-1)
      }.wont_change "Driver.count"

      # Assert
      # Check that the controller responds or redirects with whatever your group decides
      must_respond_with :redirect
      must_redirect_to drivers_path
    end
  end
end
