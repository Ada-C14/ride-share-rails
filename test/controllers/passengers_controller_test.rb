require "test_helper"

describe PassengersController do

  describe "index" do
    it "responds with success when there are many passengers saved" do
      # Arrange
      Passenger.create(name: "Jane Smith1", phone_num: "5555555555")
      Passenger.create(name: "Jane Smith2", phone_num: "5555555555")
      Passenger.create(name: "Jane Smith3", phone_num: "5555555555")
      Passenger.create(name: "Jane Smith4", phone_num: "5555555555")
      Passenger.create(name: "Jane Smith5", phone_num: "5555555555")

      # Act
      get "/passengers"
      # Assert
      must_respond_with :success

    end
  end

  describe "show" do
    before do
      @passenger = Passenger.create(name: "Jane Smith", phone_num: "5555555555")
    end

    it "responds with success when showing an existing valid passenger" do
      # Arrange
      valid_passenger_id = @passenger.id

      # Act
      get "/passengers/#{valid_passenger_id}"
      # Assert
      must_respond_with :success
    end

    it "responds with redirect with an invalid passenger id" do
      # Arrange
      invalid_passenger_id = -1

      # Act
      get "/passengers/#{invalid_passenger_id}"

      # Assert
      must_respond_with :redirect
    end
  end

  describe "new" do
    it "responds with success" do

      get new_passenger_path

      must_respond_with :success
    end
  end

  describe "create" do
    it "can create a new passenger with valid information accurately, and redirect" do
      # Arrange
      passenger_hash = {
          passenger: {
              name: "jane smith",
              phone_num: "5555555555"
          }
      }

      # Act-Assert
      expect {
        post passengers_path, params: passenger_hash
      }.must_change "Passenger.count", 1

      # Assert
      new_passenger = Passenger.find_by(name: passenger_hash[:passenger][:name])
      expect(new_passenger.name).must_equal passenger_hash[:passenger][:name]
      expect(new_passenger.phone_num).must_equal passenger_hash[:passenger][:phone_num]

      must_respond_with :redirect
      must_redirect_to passenger_path(new_passenger.id)
    end

    it "does not create a passenger if the form data violates passenger validations, and responds with a redirect" do
      # Note: This will not pass until ActiveRecord Validations lesson
      # Arrange
      # Set up the form data so that it violates passenger validations

      # Act-Assert
      # Ensure that there is no change in passenger.count

      # Assert
      # Check that the controller redirects

    end
  end

  describe "edit" do

    before do
      Passenger.create(name:"Jane Smith", phone_num:"5555555555")
    end
    it "responds with success when getting the edit page for an existing, valid passenger" do
      # Arrange
      id = Passenger.first.id
      get edit_passenger_path(id)

      # Act

      # Assert
      must_respond_with :success
    end

    it "responds with redirect when getting the edit page for a non-existing passenger" do
      # Arrange
      get edit_passenger_path(-1)

      # Act

      # Assert
      must_respond_with :redirect

    end
  end

  describe "update" do

    before do
      Passenger.create(name:"Jane Smith", phone_num:"5555555555")
    end
    let (:new_passenger_hash){
      {
          passenger:{
              name:"janesmith2",
              phone_num:"6666666666"
          },
      }
    }
    it "can update an existing passenger with valid information accurately, and redirect" do
      # Arrange
      id = Passenger.first.id
      expect {
        patch passenger_path(id), params: new_passenger_hash
      }.wont_change "Passenger.count"

      # Act-Assert
      must_respond_with :redirect

      # Assert
      passenger = Passenger.find_by(id: id)
      expect(passenger.name).must_equal new_passenger_hash[:passenger][:name]
      expect(passenger.phone_num).must_equal new_passenger_hash[:passenger][:phone_num]

    end

    it "does not update any passenger if given an invalid id, and responds with a 404" do
      id = -1
      expect{
        patch passenger_path(id), params: new_passenger_hash
      }.wont_change "Passenger.count"

      must_respond_with :not_found

    end

    it "does not create a passenger if the form data violates passenger validations, and responds with a redirect" do
      # Note: This will not pass until ActiveRecord Validations lesson
      # Arrange
      # Ensure there is an existing passenger saved
      # Assign the existing passenger's id to a local variable
      # Set up the form data so that it violates passenger validations

      # Act-Assert
      # Ensure that there is no change in passenger.count

      # Assert
      # Check that the controller redirects

    end
  end

  describe "destroy" do
    it "destroys the passenger instance in db when passenger exists, then redirects" do
      # Arrange
      passenger = Passenger.create(name:"test", phone_num: "test")

      # Act-Assert
      expect {
        delete passenger_path(passenger.id)
      }.must_change "Passenger.count", -1

      # Assert
      must_respond_with :redirect

    end

    it "does not change the db when the passenger does not exist, then responds with 404" do
      expect {
        delete passenger_path(-1)
      }.wont_change "Passenger.count"

      must_respond_with :not_found
    end

  end
end