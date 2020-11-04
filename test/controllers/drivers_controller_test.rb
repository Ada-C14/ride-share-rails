require "test_helper"

describe DriversController do
  # Note: If any of these tests have names that conflict with either the requirements or your team's decisions, feel empowered to change the test names. For example, if a given test name says "responds with 404" but your team's decision is to respond with redirect, please change the test name.
  let (:driver) {
    Driver.create(name: "Driver 1", vin: "1234")
  }
  describe "index" do
    it "responds with success when there are many drivers saved" do
      driver
      Driver.create(name: "Driver2", vin: "2345")

      get drivers_path

      must_respond_with :success

    end

    it "responds with success when there are no drivers saved" do

      get drivers_path

      must_respond_with :success

    end
  end

  describe "show" do
    it "responds with success when showing an existing valid driver" do
      id = driver.id

      get driver_path(id)

      must_respond_with :success
    end

    it "responds with 404 with an invalid driver id" do
      get driver_path(-1)

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
      driver_hash = {driver: {
          name: "Driver 1",
          vin: "12345"
      }}

      expect {
        post drivers_path, params: driver_hash
      }.must_differ "Driver.count", 1

      must_respond_with :redirect
      must_redirect_to driver_path(Driver.last.id)
      expect(Driver.last.name).must_equal driver_hash[:driver][:name]
      expect(Driver.last.vin).must_equal driver_hash[:driver][:vin]
      expect(Driver.last.available).must_equal true

    end

    it "does not create a driver if the form data violates Driver validations, and responds with a redirect" do
      no_name = {driver: {name: "", vin: "12345"}}
      no_vin = {driver: {name: "Driver Extraordinaire", vin: ""}}

      expect {
        post drivers_path, params: no_name
      }.wont_change "Driver.count"
      expect {
        post drivers_path, params: no_vin
      }.wont_change "Driver.count"

      must_respond_with :redirect
      must_redirect_to new_driver_path

    end
  end

  describe "edit" do
    it "responds with success when getting the edit page for an existing, valid driver" do
      get edit_driver_path(driver.id)

      must_respond_with :success
    end

    it "responds with redirect when getting the edit page for a non-existing driver" do
      get edit_driver_path(-1)

      must_respond_with :redirect
    end
  end

  describe "update" do
    let (:driver_hash) {
      {driver: {
          name: "Driver A",
          vin: "56789"
      }}
    }
    it "can update an existing driver with valid information accurately, and redirect" do
      id = driver.id

      expect {
        patch driver_path(id), params: driver_hash
      }.wont_change "Driver.count"

      must_redirect_to driver_path(id)

      test_driver = Driver.find_by(id: id)

      expect(test_driver.name).must_equal "Driver A"
      expect(test_driver.vin).must_equal "56789"
      expect(test_driver.available).must_equal true

    end

    it "does not update any driver if given an invalid id, and responds with a 404" do
      id = -1

      expect {
        patch driver_path(id), params: driver_hash
      }.wont_change "Driver.count"

      must_respond_with :not_found

    end

    it "does not create a driver if the form data violates Driver validations, and responds with a redirect" do
      id = driver.id
      bad_data = {
          driver: {
              name: nil,
              vin: nil
          }
      }

      expect {
        patch driver_path(id), params: bad_data
      }.wont_change "Driver.count"

      must_redirect_to edit_driver_path(id)
    end
  end

  describe "destroy" do
    it "destroys the driver instance in db when driver exists, then redirects" do
      id = driver.id

      expect {
        delete driver_path(id)
      }.must_change "Driver.count", -1

      must_respond_with :redirect
      must_redirect_to drivers_path
    end

    it "does not change the db when the driver does not exist, then responds with " do
      id = -1

      expect {
        delete driver_path(id)
      }.wont_change "Driver.count"

      must_respond_with :not_found
    end
  end
end
