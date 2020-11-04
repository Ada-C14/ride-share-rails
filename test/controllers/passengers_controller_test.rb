require "test_helper"

describe PassengersController do
  describe "index" do
    it "responds with success when there are many passengers saved" do
      # Assert
      @passenger1 = Passenger.create(name: "Kim Vitug", phone_num: "555-555-5555")
      @passenger2 = Passenger.create(name: "Sophie Messing", phone_num: "777-777-7777")
      @passenger3 = Passenger.create(name: "Valentine Messing", phone_num: "888-888-8888")

      # Act
      get passengers_path

      # Assert
      must_respond_with :success
    end

    it "responds with success when there are no passengers saved" do

      # Act
      get passengers_path

      # Assert
      must_respond_with :success
    end
  end

  describe "show" do
    before do
      @passenger1 = Passenger.create(name: "Kim Vitug", phone_num: "555-555-5555")
      @passenger2 = Passenger.create(name: "Sophie Messing", phone_num: "777-777-7777")
      @passenger3 = Passenger.create(name: "Valentine Messing", phone_num: "888-888-8888")
    end

    it "responds with success when showing an existing valid passenger" do
      # Act
      get passenger_path(@passenger1.id)

      # Assert
      must_respond_with :success
    end

    it "responds with 404 with an invalid passenger id" do
      # Act
      get passenger_path(-1)

      # Assert
      must_respond_with :not_found
    end
  end

  describe "new" do
    it "responds with success" do
      # Act
      get new_passenger_path

      # Assert
      must_respond_with :success
    end
  end

  describe "create" do
    it "can create a new passenger with valid information accurately, and redirect" do
      # Arrange
      passenger_hash = {
          passenger: {
              name: "New Passenger",
              phone_num: "444-444-4444"
          },
      }
      # Act-Assert
      expect{
        post passengers_path, params: passenger_hash
      }.must_change "Passenger.count", 1

      new_passenger = Passenger.find_by(name: passenger_hash[:passenger][:name])

      expect(new_passenger.phone_num).must_equal passenger_hash[:passenger][:phone_num]

      must_respond_with :redirect
      must_redirect_to passenger_path(new_passenger.id)
    end

    #TODO form validation tests?
    it "does not create a passenger if the form data violates Passenger validations, and responds with a redirect" do
      skip
      # Note: This will not pass until ActiveRecord Validations lesson
      # Arrange
      # Set up the form data so that it violates Passenger validations

      # Act-Assert
      # Ensure that there is no change in Passenger.count

      # Assert
      # Check that the controller redirects
    end
  end

  describe "edit" do
    before do
      @passenger1 = Passenger.create(name: "Kim Vitug", phone_num: "222-222-2222")
      @passenger2 = Passenger.create(name: "Sophie Messing", phone_num: "333-333-3333")
      @passenger3 = Passenger.create(name: "Valentine Messing", phone_num: "444-444-4444")
    end

    it "responds with success when getting the edit page for an existing, valid passenger" do
      # Act
      get edit_passenger_path(@passenger1)

      # Assert
      must_respond_with :success
    end

    it "responds with redirect when getting the edit page for a non-existing passenger" do
      # Act
      get edit_passenger_path(-1)

      # Assert
      must_respond_with :redirect
    end
  end

  describe "update" do
    before do
      Passenger.create(name: "New Passenger 1", phone_num: "111-111-1111")
    end

    let (:new_passenger_hash) {
      {
          passenger: {
              name: "Passenger 2",
              phone_num: "222-222-2222"
          }
      }
    }

    it "can update an existing passenger with valid information accurately, and redirect" do
      # Arrange
      passenger = Passenger.first

      # Act
      expect {
        patch passenger_path(passenger.id), params: new_passenger_hash
      }.wont_change 'Passenger.count'


      # Assert
      must_redirect_to passenger_path(passenger.id)

      updated_passenger = Passenger.find_by(id: passenger.id)
      expect(updated_passenger.name).must_equal new_passenger_hash[:passenger][:name]
      expect(updated_passenger.phone_num).must_equal new_passenger_hash[:passenger][:phone_num]
    end

    it "does not update any passenger if given an invalid id, and responds with a 404" do

      # Act - Assert
      expect {
        patch passenger_path(-1), params: new_passenger_hash
      }.wont_change 'Passenger.count'

      must_respond_with :not_found
    end

    it "does not create a passenger if the form data violates Passenger validations, and responds with a redirect" do
      skip
      # Note: This will not pass until ActiveRecord Validations lesson
      # Arrange
      # Ensure there is an existing passenger saved
      # Assign the existing passenger's id to a local variable
      # Set up the form data so that it violates Passenger validations

      # Act-Assert
      # Ensure that there is no change in Passenger.count

      # Assert
      # Check that the controller redirects

    end
  end

  describe "destroy" do
    it "destroys the passenger instance in db when passenger exists, then redirects" do
      # Arrange
      passenger = Passenger.create(name: "New Passenger", phone_num: "333-333-3333")
      id = passenger.id

      # Act
      expect {
        delete passenger_path(id)
      }.must_change "Passenger.count", -1

      deleted_passenger = Passenger.find_by(name: "New Passenger")

      # Assert
      expect(deleted_passenger).must_be_nil
      must_respond_with :redirect
      must_redirect_to passengers_path
    end

    it "does not change the db when the passenger does not exist, then responds with " do
      # Act
      expect {
        delete passenger_path(-1)
      }.wont_change "Passenger.count"

      # Assert
      must_respond_with :not_found
    end
  end
  end
end
