require "test_helper"

describe DriversController do
  # Note: If any of these tests have names that conflict with either the requirements or your team's decisions, feel empowered to change the test names. For example, if a given test name says "responds with 404" but your team's decision is to respond with redirect, please change the test name.

  describe "index" do
    it "responds with success when there are many drivers saved" do
      # Arrange
      Driver.create(name: "Jane Smith1")
      Driver.create(name: "Jane Smith2")
      Driver.create(name: "Jane Smith3")
      Driver.create(name: "Jane Smith4")
      Driver.create(name: "Jane Smith5")

      # Act
      get "/drivers"
      # Assert
      must_respond_with :success

    end

    it "responds with success when there are no drivers saved" do
      # Arrange
      # Ensure that there are zero drivers saved
      # Act
      get "/drivers"

      # Assert
      must_respond_with :success

    end
  end

  describe "show" do
    before do
      @driver = Driver.create(name: "Jane Smith", vin: "aaaaaaa")
    end

    it "responds with success when showing an existing valid driver" do
      # Arrange
      valid_driver_id = @driver.id

      # Act
      get "/drivers/#{valid_driver_id}"
      # Assert
      must_respond_with :success
    end

    it "responds with redirect with an invalid driver id" do
      # Arrange
      invalid_driver_id = -1
      # Ensure that there is an id that points to no driver

      # Act
      get "/drivers/#{invalid_driver_id}"

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
      driver_hash = {
          driver: {
              name: "jane smith",
              vin: "122fghjy3bfgd"
          }
      }

      # Act-Assert
      expect {
        post drivers_path, params: driver_hash
      }.must_change "Driver.count", 1

      # Assert
      new_driver = Driver.find_by(name: driver_hash[:driver][:name])
      expect(new_driver.name).must_equal driver_hash[:driver][:name]
      expect(new_driver.vin).must_equal driver_hash[:driver][:vin]

      must_respond_with :redirect
      must_redirect_to driver_path(new_driver.id)
    end

    it "does not create a driver if the form data violates Driver validations, and responds with a redirect" do
      driver_hash = {
          driver: {
              name: "jane smith",
              vin: ""
          }
      }
      expect {
        post drivers_path, params: driver_hash
      }.wont_change "Driver.count"

      must_respond_with :bad_request


    end
  end
  
  describe "edit" do

    before do
      Driver.create(name:"Jane Smith", vin:"sv1d65gb6ht1ws")
    end
    it "responds with success when getting the edit page for an existing, valid driver" do
      # Arrange
      id = Driver.first.id
      get edit_driver_path(id)

      # Act

      # Assert
      must_respond_with :success
    end

    it "responds with redirect when getting the edit page for a non-existing driver" do
      # Arrange
      get edit_driver_path(-1)

      # Act

      # Assert
      must_respond_with :redirect

    end
  end

  describe "update" do

    before do
      Driver.create(name:"Jane Smith", vin:"sv1d65gb6ht1ws")
    end
    let (:new_driver_hash){
      {
          driver:{
              name:"janesmith2",
              vin:"45h465jnvwsfm"
          },
      }
    }
    it "can update an existing driver with valid information accurately, and redirect" do
      # Arrange
      id = Driver.first.id
      expect {
        patch driver_path(id), params: new_driver_hash
      }.wont_change "Driver.count"

      # Act-Assert
      must_respond_with :redirect

      # Assert
      driver = Driver.find_by(id: id)
      expect(driver.name).must_equal new_driver_hash[:driver][:name]
      expect(driver.vin).must_equal new_driver_hash[:driver][:vin]

    end

    it "does not update any driver if given an invalid id, and responds with a 404" do
      # Arrange
      id = -1
      expect{
        patch driver_path(id), params: new_driver_hash
      }.wont_change "Driver.count"

      # Act-Assert
      must_respond_with :not_found

      # Assert
      # Check that the controller gave back a 404

    end

    it "does not edit a driver if the form data violates Driver validations, and responds with a redirect" do
      Driver.create(name: "Jane Smith", vin: "aaaaaaa")


      id = Driver.last.id
      invalid_driver_hash = {
          driver:{
              name:"janesmith2",
              vin:nil
          },
      }
      expect {
        patch driver_path(id), params: invalid_driver_hash
      }.wont_change "Driver.count"

      must_respond_with :bad_request

      driver = Driver.find_by(id: id)
      expect(driver.name).must_equal "Jane Smith"
      expect(driver.vin).must_equal "aaaaaaa"
    end
  end

  describe "destroy" do
    it "destroys the driver instance in db when driver exists, then redirects" do
      # Arrange
      driver = Driver.create(name:"test", vin: "test")

      # Act-Assert
      expect {
        delete driver_path(driver.id)
      }.must_change "Driver.count", -1

      # Assert
      must_respond_with :redirect

    end

    it "does not change the db when the driver does not exist, then responds with 404" do
    expect {
      delete driver_path(-1)
    }.wont_change "Driver.count"
    must_respond_with :not_found
    end

  end
end
