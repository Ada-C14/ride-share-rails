require "test_helper"

describe DriversController do
  # Note: If any of these tests have names that conflict with either the requirements or your team's decisions, feel empowered to change the test names. For example, if a given test name says "responds with 404" but your team's decision is to respond with redirect, please change the test name.
  let (:driver) {
    Driver.create name: 'test_driver0', vin: 'ABCDEFGHIJKLMN0', available: true
  }

  describe "index" do

    it "can get the index path" do
      # Act
      get drivers_path
      # Assert
      must_respond_with :success
    end

    it "can get the root path" do
      # Act
      get root_path

      # Assert
      must_respond_with :success
    end

    it "responds with success when there are many drivers saved" do
      # Arrange
      # Ensure that there is at least one Driver saved
      drivers_arr_hsh =  [
          {name: 'test_driver1', vin: 'ABCDEFGHIJKLMN1', available: true},
          {name: 'test_driver2', vin: 'ABCDEFGHIJKLMN2', available: true},
          {name: 'test_driver3', vin: 'ABCDEFGHIJKLMN3', available: false}
      ]


      # Act-Assert
      # :driver =>
      drivers_arr_hsh.each do |driver|
        expect{
          post drivers_path, params: { driver: {name: driver[:name], vin: driver[:vin], available: driver[:available]} }
        }.must_change "Driver.count", 1
      end
    end

    it "responds with success when there are no drivers saved" do
      # Arrange
      # Ensure that there are zero drivers saved
      # when seeing index page with no drivers, no errors, can be re-direct to homepage

      # Act

      # Assert

    end
  end

  describe "show" do
    it "responds with success when showing an existing valid driver" do
      # Arrange
      # Ensure that there is a driver saved
      # Act
      get driver_path(driver.id)
      # Assert
      must_respond_with :success

    end

    it "responds with a redirect for an invalid driver" do
      # Arrange
      # Ensure that there is an id that points to no driver

      # Act
      get driver_path(-1)

      # Assert
      must_respond_with :redirect

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

    # let (:driver) {
    #   Driver.create name: 'test_driver4', vin: 'ABCDEFGHIJKLMN4', available: true
    # }
    # pp driver.name

    it "can create a new driver with valid information accurately, and redirect" do
      # Arrange
      # Set up the form data
      new_driver_hsh = {
          driver: {
              name: 'test driver',
              vin: 'ABC1234',
              available: true }
      }

      # Act-Assert
      # Ensure that there is a change of 1 in Driver.count
       expect {
            post drivers_path, params: new_driver_hsh
          }.must_change "Driver.count", 1

      # Assert
      # Find the newly created Driver, and check that all its attributes match what was given in the form data
      new_driver_check = Driver.find_by(name: new_driver_hsh[:driver][:name])

      expect(new_driver_check.vin).must_equal new_driver_hsh[:driver][:vin]
      expect(new_driver_check.available).must_equal new_driver_hsh[:driver][:available]

      #Check that the controller redirected the user
      must_respond_with :redirect
      must_redirect_to driver_path(new_driver_check.id)


    end

    it "does not create a driver if the form data violates Driver validations, and responds with a redirect" do
      skip
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
      # Ensure there is an existing driver saved
      # Act
      get edit_driver_path(driver.id)

      must_respond_with :success
      # Assert

    end

    it "responds with redirect when getting the edit page for a non-existing driver" do
      # Arrange
      # Ensure there is an invalid id that points to no driver

      # Act
      get edit_driver_path(-1)

      # Assert
      must_respond_with :redirect

    end
  end

  describe "update" do
    it "can update an existing driver with valid information accurately, and redirect" do
      # Arrange
      # Ensure there is an existing driver saved
      # Assign the existing driver's id to a local variable
      # Set up the form data
      newest_driver_id = Driver.last.id

      updated_newest_driver = {
          driver: {
              name: 'test driver again',
              vin: 'ABC123456',
              available: false
          }
      }
      # Act-Assert
      # Ensure that there is no change in Driver.count
      expect {
        patch driver_path(newest_driver_id), params: updated_newest_driver
      }.wont_change 'Driver.count'

      # Assert
      # Use the local variable of an existing driver's id to find the driver again, and check that its attributes are updated
      # Check that the controller redirected the user
      after_updating = Driver.find_by(id: newest_driver_id)

      expect( after_updating.name ).must_equal updated_newest_driver[:driver][:name]
      expect( after_updating.vin ).must_equal updated_newest_driver[:driver][:vin]
      expect( after_updating.available ).must_equal updated_newest_driver[:driver][:available]

      must_respond_with :redirect
    end

    it "does not update any driver if given an invalid id, and responds with a redirect" do
      # Arrange
      # Ensure there is an invalid id that points to no driver
      # Set up the form data

      # Act-Assert
      # Ensure that there is no change in Driver.count
      patch driver_path(-1)
      # Assert
      # Check that the controller gave back a 404 >>redirect
      must_respond_with :redirect
    end

    it "does not create a driver if the form data violates Driver validations, and responds with a redirect" do
      skip
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
      # Ensure there is an existing driver saved

      # Act-Assert
      # Ensure that there is a change of -1 in Driver.count

      # Assert
      # Check that the controller redirects

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
