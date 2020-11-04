require "test_helper"

describe PassengersController do
  describe "index" do
    it "responds with success when there are many passengers saved" do
      # Arrange
      # Ensure that there is at least one Driver saved
      @passenger = Passenger.create(name: "Judy", phone_num: "360-555-0987")

      # Act
      get "/passengers"

      # Assert
      expect(Passenger.count).must_equal 1
      must_respond_with :success
    end

    it "responds with success when there are no passengers saved" do
      # Arrange
      # Ensure that there are zero drivers saved

      # Act
      get "/passengers"
      # Assert
      expect(Passenger.count).must_equal 0
      must_respond_with :success
    end
  end

  describe "show" do
    before do
      Passenger.create(name: "Gertrude", phone_num: "360-555-4535")
    end

    it "responds with success when showing an existing valid passenger" do
      # Arrange
      # Ensure that there is a driver saved
      valid_passenger_id = Passenger.first.id

      # Act
      get "/passengers/#{ valid_passenger_id }"

      # Assert
      must_respond_with :success
    end

    it "responds with 404 with an invalid passenger id" do
      # Arrange
      # Ensure that there is an id that points to no driver
      invalid_passenger_id = -1

      # Act
      get "/passengers/#{ invalid_passenger_id }"

      # Assert
      must_respond_with :not_found
    end
  end

  describe "new" do
    before do
      Passenger.create(name: "Gladys", phone_num: "360-555-8263")
    end

    it "can get the new_passenger_path" do
      get new_passenger_path

      must_respond_with :success
    end

    it "responds with success" do
      get new_passenger_path(Passenger.first.id)

      must_respond_with :success
    end
  end

  describe "create" do
    let (:passenger) {
      {
          passenger: {
              name: "Ignatious",
              phone_num: "360-555-3245"
          }
      }
    }

    it "can create a new passenger with valid information accurately, and redirect" do
      # Arrange
      # Set up the form data
      # Act-Assert
      # Ensure that there is a change of 1 in Driver.count
      expect {
        post passengers_path, params: passenger
      }.must_differ 'Passenger.count', 1

      # Assert
      # Find the newly created Driver, and check that all its attributes match what was given in the form data
      expect(Passenger.last.name).must_equal passenger[:passenger][:name]
      expect(Passenger.last.phone_num).must_equal passenger[:passenger][:phone_num]

      # Check that the controller redirected the user
      must_respond_with  :redirect
      must_redirect_to root_path
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
    before do
      Passenger.create(name: "Norman", phone_num: "360-555-9274")
    end

    it "responds with success when getting the edit page for an existing, valid passenger" do
      # Arrange
      # Ensure there is an existing driver saved
      # Act
      get edit_passenger_path(Passenger.first.id)

      # Assert
      must_respond_with :success
    end

    it "responds with redirect when getting the edit page for a non-existing passenger" do
      # Arrange
      # Ensure there is an invalid id that points to no driver
      # Act
      get edit_passenger_path(-1)

      # Assert
      must_redirect_to passengers_path
    end
  end

  describe "update" do
    before do
      Passenger.create(name: "Ursula", phone_num: "360-555-9257")
    end

    let (:passenger) {
      {
          passenger: {
              name: "Candace",
              phone_num: "206-555-8376"
          }
      }
    }

    it "can update an existing passenger with valid information accurately, and redirect" do
      # Arrange
      # Ensure there is an existing driver saved
      # Assign the existing driver's id to a local variable
      # Set up the form data
      id = Passenger.first.id

      # Act-Assert
      # Ensure that there is no change in Driver.count
      expect {
        patch passenger_path(id), params: passenger
      }.wont_change 'Passenger.count'

      # Assert
      # Use the local variable of an existing driver's id to find the driver again, and check that its attributes are updated
      updated_pass = Passenger.find_by(id: id)
      expect(updated_pass.name).must_equal passenger[:passenger][:name]
      expect(updated_pass.phone_num).must_equal passenger[:passenger][:phone_num]

      # Check that the controller redirected the user
      must_redirect_to passenger_path(id)

    end

    it "does not update any passenger if given an invalid id, and responds with a 404" do
      # Arrange
      # Ensure there is an invalid id that points to no driver
      # Set up the form data
      id = -1

      # Act-Assert
      # Ensure that there is no change in Driver.count
      expect {
        patch passenger_path(id), params: passenger
      }.wont_change 'Passenger.count'

      # Assert
      # Check that the controller gave back a 404
      must_respond_with :not_found
    end

    it "does not create a passenger if the form data violates passenger validations, and responds with a redirect" do
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
    it "destroys the passenger instance in db when passenger exists, then redirects" do
      # Arrange
      # Ensure there is an existing driver saved

      # Act-Assert
      # Ensure that there is a change of -1 in Driver.count

      # Assert
      # Check that the controller redirects

    end

    it "does not change the db when the passenger does not exist, then responds with " do
      # Arrange
      # Ensure there is an invalid id that points to no driver
      id = -1

      # Act-Assert
      # Ensure that there is no change in Driver.count
      expect {
        delete passenger_path(id)
      }.wont_change "Passenger.count"

      # Assert
      # Check that the controller responds or redirects with whatever your group decides
      must_respond_with :not_found
    end
  end
end
