require "test_helper"

describe PassengersController do
  before do
    @passenger = Passenger.create(name: "Judy", phone_num: "360-555-0987")
  end
  describe "index" do
    it "responds with success when there are many passengers saved" do
      # Arrange
      passenger = @passenger

      # Act
      get "/passengers"

      # Assert
      expect(Passenger.count).must_be :>=, 1
      must_respond_with :success
    end

    it "responds with success when there are no passengers saved" do
      # Arrange
      Passenger.delete_all

      # Act
      get "/passengers"

      # Assert
      expect(Passenger.count).must_equal 0
      must_respond_with :success
    end
  end

  describe "show" do
    it "responds with success when showing an existing valid passenger" do
      # Arrange
      valid_passenger_id = Passenger.first.id

      # Act
      get "/passengers/#{ valid_passenger_id }"

      # Assert
      must_respond_with :success
    end

    it "responds with 404 with an invalid passenger id" do
      # Arrange
      invalid_passenger_id = -1

      # Act
      get "/passengers/#{ invalid_passenger_id }"

      # Assert
      must_respond_with :not_found
    end
  end

  describe "new" do
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

    let (:invalid_passenger_name) { 
      { 
        passenger: {
          name: nil, 
          phone_num: "360-555-3245"
        }
      }    
    }

    let (:invalid_passenger_phone_num) { 
      { 
        passenger: {
          name: "Ignatious", 
          phone_num: nil
        }
      }    
    }

    it "can create a new passenger with valid information accurately, and redirect" do
      # Arrange
      expect {
        post passengers_path, params: passenger
      }.must_differ 'Passenger.count', 1

      # Assert
      expect(Passenger.last.name).must_equal passenger[:passenger][:name]
      expect(Passenger.last.phone_num).must_equal passenger[:passenger][:phone_num]

      # Check that the controller redirected the user
      must_respond_with :redirect
      must_redirect_to passengers_path
    end

    it "does not create a passenger if the form data violates Passenger validations - name, and responds with a redirect" do
      # Act-Assert
      # Ensure that there is no change in Driver.count
      expect {
        post passengers_path, params: invalid_passenger_name
      }.must_differ 'Passenger.count', 0

      # Assert
      # Check that the controller redirects
      must_respond_with :bad_request
    end

    it "does not create a passenger if the form data violates Passenger validations - phone number, and responds with a redirect" do
      # Act-Assert
      # Ensure that there is no change in Driver.count
      expect {
        post passengers_path, params: invalid_passenger_phone_num
      }.must_differ 'Passenger.count', 0

      # Assert
      # Check that the controller redirects
      must_respond_with :bad_request
    end
  end

  describe "edit" do
    it "responds with success when getting the edit page for an existing, valid passenger" do
      # Arrange & Act
      get edit_passenger_path(Passenger.first.id)

      # Assert
      must_respond_with :success
    end

    it "responds with redirect when getting the edit page for a non-existing passenger" do
      # Arrange & Act
      get edit_passenger_path(-1)

      # Assert
      must_redirect_to passengers_path
    end
  end

  describe "update" do
    let (:passenger) {
      {
          passenger: {
              name: "Candace",
              phone_num: "206-555-8376"
          }
      }
    }

    let (:invalid_passenger_name) { 
      { 
        passenger: {
          name: nil, 
          phone_num: "360-555-3245"
        }
      }    
    }

    let (:invalid_passenger_phone_num) { 
      { 
        passenger: {
          name: "Ignatious", 
          phone_num: nil
        }
      }    
    }

    it "can update an existing passenger with valid information accurately, and redirect" do
      # Arrange
      id = Passenger.first.id

      # Act-Assert
      expect {
        patch passenger_path(id), params: passenger
      }.wont_change 'Passenger.count'

      # Assert
      updated_pass = Passenger.find_by(id: id)
      expect(updated_pass.name).must_equal passenger[:passenger][:name]
      expect(updated_pass.phone_num).must_equal passenger[:passenger][:phone_num]

      # Check that the controller redirected the user
      must_redirect_to passenger_path(id)
    end

    it "does not update any passenger if given an invalid id, and responds with a 404" do
      # Arrange
      id = -1

      # Act-Assert
      expect {
        patch passenger_path(id), params: passenger
      }.wont_change 'Passenger.count'

      # Assert
      must_respond_with :not_found
    end

    it "does not update a passenger if the form data violates Passenger validations - name, and responds with a redirect" do
      # Arrange
      id = Passenger.first.id
      
      # Act-Assert
      expect {
        patch passenger_path(id), params: invalid_passenger_name
      }.must_differ 'Passenger.count', 0

      # Assert
      # Check that the controller redirects
      must_respond_with :bad_request
    end

    it "does not update a passenger if the form data violates Passenger validations - phone number, and responds with a redirect" do
      # Arrange
      id = Passenger.first.id

      # Act-Assert
      expect {
        patch passenger_path(id), params: invalid_passenger_phone_num
      }.must_differ 'Passenger.count', 0

      # Assert
      must_respond_with :bad_request
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
      id = -1

      # Act-Assert
      expect {
        delete passenger_path(id)
      }.wont_change "Passenger.count"

      # Assert
      must_respond_with :not_found
    end
  end
end
