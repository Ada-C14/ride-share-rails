require "test_helper"

describe DriversController do
  before do
    @driver = Driver.create!(name: "Test Driver", vin: "123456", available: true)
  end
  # Note: If any of these tests have names that conflict with either the requirements or your team's decisions, feel empowered to change the test names. For example, if a given test name says "responds with 404" but your team's decision is to respond with redirect, please change the test name.

  describe "index" do
    it "responds with success when there are many drivers saved" do
      get drivers_path
      # Ensure that there is at least one Driver saved

      # Act
      must_respond_with :success
      # Assert

    end

    it "responds with success when there are no drivers saved" do
      # Ensure that there are zero drivers saved
      # Act
      expect {
        delete driver_path(@driver.id)
      }.must_differ 'Driver.count', -1

      # Assert
      get drivers_path
      must_respond_with :success

    end
  end

  describe "show" do
    it "responds with success when showing an existing valid driver" do
      # Arrange
      
      # Ensure that there is a driver saved

      # Act
      get driver_path(@driver.id)
      # Assert
      must_respond_with :success

    end

    it "redirects for an invalid driver id" do
      # Arrange
      bad_id = -9999
      # Ensure that there is an id that points to no driver

      # Act
      get driver_path(bad_id)

      # Assert
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
    it "can create a new driver with valid information accurately, and redirect" do
      # Arrange
      driver_hash = {
        driver: {
          name: 'new driver',
          vin: '123456',
          available: true
        }
      }

      expect {
        post drivers_path, params: driver_hash
      }.must_differ 'Driver.count', 1

      new_driver = Driver.find_by(name: driver_hash[:driver][:name])
      expect(new_driver.name).must_equal driver_hash[:driver][:name]
      expect(new_driver.vin).must_equal driver_hash[:driver][:vin]
      expect(new_driver.available).must_equal driver_hash[:driver][:available]

      must_respond_with :redirect
      must_redirect_to drivers_path(new_driver.id)

    end

    it "does not create a driver if the form data violates Driver validations" do
       # Arrange
       driver_hash = {
        driver: {
          vin: '123456',
          available: true
        }
      }
      # Note: This will not pass until ActiveRecord Validations lesson
      # Arrange
      # Set up the form data so that it violates Driver validations

      # Act-Assert
      expect {
        post drivers_path, params: driver_hash
      }.wont_change 'Driver.count'

      # Ensure that there is no change in Driver.count

      # Assert
      must_respond_with :success
      
      # Check that the controller redirects

    end
  end
  
  describe "edit" do
    it "responds with success when getting the edit page for an existing, valid driver" do
      get edit_driver_path(@driver.id)
      # Arrange
      # Ensure there is an existing driver saved

      # Act

      # Assert
      must_respond_with :success

    end

    it "responds with redirect when getting the edit page for a non-existing driver" do
    
      # Arrange
      get driver_path(-1)
      # Ensure there is an invalid id that points to no driver

      # Act

      # Assert
      must_respond_with :redirect
      must_redirect_to drivers_path
    end
  end

  describe "update" do
    let (:new_driver_hash) {
      {
        driver: {
          name: 'A Wrinkle in Time',
          vin: 'A fabulous adventure',
          available: true
        }
      }
    }
    it "can update an existing driver with valid information accurately, and redirect" do
     
      # Arrange
      
      # Ensure there is an existing driver saved
      # Assign the existing driver's id to a local variable
      # Set up the form data

      # Act-Assert
      expect {
        patch driver_path(@driver.id), params: new_driver_hash # the params method set the data structure 
        }.wont_change 'Driver.count'
      # Ensure that there is no change in Driver.count

      # Assert
      driver = Driver.find_by(id: @driver.id)
      expect(driver.name).must_equal new_driver_hash[:driver][:name]
      expect(driver.vin).must_equal new_driver_hash[:driver][:vin]
      expect(driver.available).must_equal new_driver_hash[:driver][:available]

      must_respond_with :redirect
      must_redirect_to drivers_path
      
      # Use the local variable of an existing driver's id to find the driver again, and check that its attributes are updated
      # Check that the controller redirected the user

    end

    it "does not update any driver if given an invalid id, and responds with a redirect" do
      
      # Arrange
      patch driver_path(-1)
      # Ensure there is an invalid id that points to no driver
      # Set up the form data

      # Act-Assert
      expect {
        patch driver_path(-1), params: new_driver_hash # the params method set the data structure 
        }.wont_change 'Driver.count'
      # Ensure that there is no change in Driver.count

      # Assert
      must_respond_with :redirect
      must_redirect_to drivers_path
      # Check that the controller gave back a 404

    end

    it "does not update a driver if the form data violates Driver validations, and responds with a redirect" do
       # Arrange
       driver_hash = {
        driver: {
          vin: '123456',
          available: true
        }
      }
      # Note: This will not pass until ActiveRecord Validations lesson
      # Arrange
      # Set up the form data so that it violates Driver validations

      # Act-Assert
      expect {
        patch driver_path(id: @driver.id), params: driver_hash
      }.wont_change 'Driver.count'

      # Ensure that there is no change in Driver.count

      # Assert
      must_respond_with :redirect
      must_redirect_to drivers_path
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
      expect {
        delete driver_path(@driver.id)

      # Assert
      }.must_change 'Driver.count', -1
    
      driver = Driver.find_by(name: @driver.name)

      expect(driver).must_be_nil

      must_respond_with :redirect
      must_redirect_to drivers_path

      # Arrange
      # Ensure there is an existing driver saved

      # Act-Assert
      # Ensure that there is a change of -1 in Driver.count

      # Assert
      # Check that the controller redirects

    end

    it "does not change the db when the driver does not exist, then responds with redirect " do
      expect {
        delete driver_path(-1)
      }.wont_change 'Driver.count'

      must_respond_with :redirect
      must_redirect_to drivers_path

      # Arrange
      # Ensure there is an invalid id that points to no driver

      # Act-Assert
      # Ensure that there is no change in Driver.count

      # Assert
      # Check that the controller responds or redirects with whatever your group decides

    end
  end
end
