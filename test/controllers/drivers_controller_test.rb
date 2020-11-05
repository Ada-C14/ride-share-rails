require "test_helper"

describe DriversController do

  describe "index" do
    it "responds with success when there are many drivers saved" do
      # Assert
      @driver1 = Driver.create(name: "Kim Vitug", vin: "W23423SAFSE")
      @driver2 = Driver.create(name: "Sophie Messing", vin: "DFASDFW3534")
      @driver3 = Driver.create(name: "Valentine Messing", vin: "DFAS645623E")

      # Act
      get drivers_path

      # Assert
      must_respond_with :success
    end

    it "responds with success when there are no drivers saved" do

      # Act
      get drivers_path

      # Assert
      must_respond_with :success
    end
  end

  describe "show" do
    before do
      @driver1 = Driver.create(name: "Kim Vitug", vin: "W23423SAFSE")
      @driver2 = Driver.create(name: "Sophie Messing", vin: "DFASDFW3534")
      @driver3 = Driver.create(name: "Valentine Messing", vin: "DFAS645623E")
    end

    it "responds with success when showing an existing valid driver" do
      # Act
      get driver_path(@driver1.id)

      # Assert
      must_respond_with :success
    end

    it "responds with 404 with an invalid driver id" do
      # Act
      get driver_path(-1)

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
      driver_hash = {
          driver: {
              name: "New Driver",
              vin: "DFADSF24324"
          },
      }
      # Act-Assert
      expect{
        post drivers_path, params: driver_hash
      }.must_change "Driver.count", 1

      new_driver = Driver.find_by(name: driver_hash[:driver][:name])

      expect(new_driver.vin).must_equal driver_hash[:driver][:vin]
      expect(new_driver.available).must_equal true

      must_respond_with :redirect
      must_redirect_to driver_path(new_driver.id)
    end

    it "does not create a driver if the form data violates Driver validations, and responds with a redirect" do
      # Arrange
      driver_hash = {
          driver: {
              name: "Lady Gaga",
              vin: "DFADSF24324"
          },
      }

      # Set up the form data so that it violates Driver validations
      driver_hash[:driver][:name] = nil

      # Act-Assert
      # Ensure that there is no change in Driver.count
      expect{
        post drivers_path, params: driver_hash
      }.wont_change "Driver.count"

      # Assert
      # Check that the controller redirects
      must_respond_with :bad_request

    end
  end
  
  describe "edit" do
    before do
      @driver1 = Driver.create(name: "Kim Vitug", vin: "W23423SAFSE")
      @driver2 = Driver.create(name: "Sophie Messing", vin: "DFASDFW3534")
      @driver3 = Driver.create(name: "Valentine Messing", vin: "DFAS645623E")
    end

    it "responds with success when getting the edit page for an existing, valid driver" do
      # Act
      get edit_driver_path(@driver1)

      # Assert
      must_respond_with :success
    end

    it "responds with redirect when getting the edit page for a non-existing driver" do
      # Act
      get edit_driver_path(-1)

      # Assert
      must_respond_with :redirect
    end
  end

  describe "update" do
    before do
      Driver.create(name: "New Driver 1", vin: "DFASDFA32432")
    end

    let (:new_driver_hash) {
      {
          driver: {
              name: "Driver 2",
              vin: "ADFAGFER4353"
          }
      }
    }

    it "can update an existing driver with valid information accurately, and redirect" do
      # Arrange
      driver = Driver.first

      # Act
      expect {
        patch driver_path(driver.id), params: new_driver_hash
      }.wont_change 'Driver.count'


      # Assert
      must_redirect_to driver_path(driver.id)

      updated_driver = Driver.find_by(id: driver.id)
      expect(updated_driver.name).must_equal new_driver_hash[:driver][:name]
      expect(updated_driver.vin).must_equal new_driver_hash[:driver][:vin]
      expect(updated_driver.available).must_equal true
    end

    it "does not update any driver if given an invalid id, and responds with a 404" do

      # Act - Assert
      expect {
        patch driver_path(-1), params: new_driver_hash
      }.wont_change 'Driver.count'

      must_respond_with :not_found
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
      driver = Driver.create(name: "New Driver", vin: "4534DASDGFA")
      id = driver.id

      # Act
      expect {
        delete driver_path(id)
      }.must_change "Driver.count", -1

      deleted_driver = Driver.find_by(name: "New Driver")

      # Assert
      expect(deleted_driver).must_be_nil
      must_respond_with :redirect
      must_redirect_to drivers_path
    end

    it "does not change the db when the driver does not exist, then responds with " do
      # Act
      expect {
        delete driver_path(-1)
      }.wont_change "Driver.count"

      # Assert
      must_respond_with :not_found

    end
  end
end
