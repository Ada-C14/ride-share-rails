# frozen_string_literal: true

require 'test_helper'

describe DriversController do
  # Note: If any of these tests have names that conflict with either the requirements or your team's decisions, feel empowered to change the test names. For example, if a given test name says "responds with 404" but your team's decision is to respond with redirect, please change the test name.
  let(:driver) do
    Driver.create name: 'Ayesha', vin: 'BCTSH52M8YERVGDK9', available: true
  end
  describe 'index' do
    it 'responds with success when there are many drivers saved' do
      get drivers_path

      # Assert
      must_respond_with :success
    end

    it 'responds with success when there are no drivers saved' do
      get drivers_path

      must_respond_with :success
    end
  end

  describe 'show' do
    it 'responds with success when showing an existing valid driver' do
      get driver_path(driver.id)

      must_respond_with :success
    end

    it 'responds with 404 with an invalid driver id' do
      get driver_path(-1)

      # Assert
      must_respond_with :not_found
    end
  end

  describe 'new' do
    it 'responds with success' do
      # Act
      get new_driver_path

      # Assert
      must_respond_with :success
    end
  end

  describe 'create' do
    it 'can create a new driver with valid information accurately, and redirect' do
      driver_params = {
        driver: {
          name: 'Roshni',
          vin: 'BCTSH52M8YERVGDKD9',
          available: true
        }
      }

      # Act-Assert
      expect do
        post drivers_path, params: driver_params
      end.must_change 'Driver.count', 1

      new_driver = Driver.find_by(name: driver_params[:driver][:name])
      expect(new_driver.vin).must_equal driver_params[:driver][:vin]
      expect(new_driver.available).must_equal driver_params[:driver][:available]

      must_respond_with :redirect
      must_redirect_to driver_path(new_driver.id)
    end

    it 'will redirect to the driver_path' do
      driver_params = {
        driver: {
          name: 'Test Driver',
          vin: 'BCTSH52M8YERVGDK9',
          available: true
        }
      }

      post drivers_path, params: driver_params

      new_driver = Driver.find_by(name: driver_params[:driver][:name])

      must_redirect_to driver_path(new_driver.id)
    end

    it 'will add a new driver to the database' do
      driver_params = {
        driver: {
          name: 'Ayesha',
          vin: 'BCTSH52M8YERVGDK9',
          available: true
        }
      }

      expect do
        post drivers_path, params: driver_params
      end.must_change 'Driver.count', 1
    end

    it 'does not update a driver if the form data violates Driver validations, and responds with a redirect' do
      # Note: This will not pass until ActiveRecord Validations lesson
      # Arrange
      # Set up the form data so that it violates Driver validations
      driver_params = {
        driver: {
          name: 'invalid driver',
          vin: nil,
          available: false
        }
      }

      # Act-Assert
      # Ensure that there is no change in Driver.count
      expect do
        post drivers_path, params: driver_params
      end.must_differ 'Driver.count', 0

      # Assert
      # Check that the controller redirects
      must_respond_with :redirect
    end
  end

  describe 'edit' do
    it 'responds with success when getting the edit page for an existing, valid driver' do
      get edit_driver_path(driver.id)

      must_respond_with :success
    end

    it 'responds with redirect when getting the edit page for a non-existing driver' do
      get edit_driver_path(-1)

      must_respond_with :redirect
    end
  end

  describe 'update' do
    before do
      Driver.create(name: 'Roshni', vin: 'BC57H3DM8YEBHGMI9', available: true)
    end
    let(:new_driver_hash) do
      {
        driver: {
          name: 'Ayesha',
          vin: 'BCTSH52M8YERVGDK9',
          available: true
        }
      }
    end
    it 'can update an existing driver with valid information accurately, and redirect' do
      id = Driver.first.id
      expect do
        patch driver_path(id), params: new_driver_hash
      end.wont_change 'Driver.count'

      must_redirect_to driver_path

      driver = Driver.find_by(id: id)
      expect(driver.name).must_equal new_driver_hash[:driver][:name]
      expect(driver.vin).must_equal new_driver_hash[:driver][:vin]
      expect(driver.available).must_equal new_driver_hash[:driver][:available]
    end

    it 'does not update any driver if given an invalid id, and responds with a 404' do
      id = -1

      expect do
        patch driver_path(id), params: new_driver_hash
      end.wont_change 'Driver.count'

      must_respond_with :not_found
    end

    it 'does not create a driver if the form data violates Driver validations, and responds with a redirect' do
      # Note: This will not pass until ActiveRecord Validations lesson
      # Arrange
      # Ensure there is an existing driver saved
      driver
      # Assign the existing driver's id to a local variable
      id = driver.id
      # Set up the form data so that it violates Driver validations
      driver_params = {
        driver: {
          name: nil,
          vin: nil,
          available: false
        }
      }
      # Act-Assert
      # Ensure that there is no change in Driver.count
      expect do
        patch driver_path(id), params: driver_params
      end.must_differ 'Driver.count', 0
      # Assert
      # Check that the controller redirects
      must_respond_with :redirect
    end
  end

  describe 'destroy' do
    it 'destroys the driver instance in db when driver exists, then redirects to root_path' do
      new_driver = Driver.create(name: 'Roshni', vin: 'BCTSH52M8YERVGDK9', available: true)


      id = new_driver.id

      # Act
      expect do
        delete driver_path(id)

        # Assert
      end.must_change 'Driver.count', -1

      must_respond_with :redirect
      must_redirect_to root_path
    end

    it 'does not change the db when the driver does not exist, then responds with 404' do
      id = -1

      expect do
        delete driver_path(id)
      end.wont_change 'Driver.count'

      must_respond_with :not_found
    end
  end
end
