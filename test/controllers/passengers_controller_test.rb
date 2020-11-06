require "test_helper"

describe PassengersController do
  # Note: If any of these tests have names that conflict with either the requirements or your team's decisions, feel empowered to change the test names. For example, if a given test name says "responds with 404" but your team's decision is to respond with redirect, please change the test name.
  let (:passenger) {
    {name: "John Smith", phone_num: "WBWSS52P9NEYLVDE9"}
  }

  describe "index" do
    it "responds with success when there are passengers saved" do
      # Arrange
      # Ensure that there is at least one Passenger saved
      Passenger.create(passenger)
      # Act
      get passengers_path
      # Assert
      must_respond_with :success
    end

    it "responds with success when there are no passengers saved" do
      # Arrange
      # Ensure that there are zero passengers saved

      # Act
      get passengers_path
      # Assert
      must_respond_with :success
    end
  end

  describe "show" do
    it "responds with success when showing an existing valid passenger" do
      # Arrange
      # Ensure that there is a passenger saved
      passenger_1 =Passenger.create(passenger)

      # Act
      get passenger_path(passenger_1.id)
      # Assert
      must_respond_with :success
    end

    it "responds with 404 with an invalid passenger id" do
      # Arrange
      # Ensure that there is an id that points to no passenger

      # Act
      get passenger_path(-1)
      # Assert
      must_redirect_to passengers_path
    end
  end

  describe "new" do
    it "responds with success" do
      get new_passenger_path

      must_respond_with :success
    end
  end

  describe "create" do
    let (:passenger_hash) {
      {passenger: {
          name: "new passenger",
          phone_num: "1B9WEX2R92R12900E",
      }
      }}
    it "can create a new passenger with valid information accurately, and redirect" do
      # Arrange
      # Set up the form data
      # Act-Assert
      # Ensure that there is a change of 1 in Passenger.count
      expect {
        post passengers_path, params: passenger_hash
      }.must_change "Passenger.count", 1
      # Assert
      # Find the newly created Passenger, and check that all its attributes match what was given in the form data
      # Check that the controller redirected the user
      new_passenger = Passenger.find_by(name: passenger_hash[:passenger][:name])
      expect(new_passenger.phone_num).must_equal passenger_hash[:passenger][:phone_num]

      must_respond_with :redirect
      must_redirect_to passenger_path(new_passenger.id)
    end

    it "does not create a passenger if the form data violates Passenger validations, and responds with a redirect" do
      # Note: This will not pass until ActiveRecord Validations lesson
      # Arrange
      # Set up the form data so that it violates Passenger validations
      passenger_hash[:passenger][:phone_num] = ""
      # Act-Assert
      # Ensure that there is no change in Passenger.count
      expect {
        post passengers_path, params: passenger_hash
      }.wont_change "Passenger.count"
      # Assert
      # Check that the controller redirects
      must_respond_with :success
    end
  end

  describe "edit" do
    it "responds with success when getting the edit page for an existing, valid passenger" do
      # Arrange
      # Ensure there is an existing passenger saved
      passenger_1 =Passenger.create(passenger)
      # Act
      get edit_passenger_path(passenger_1.id)

      # Assert
      must_respond_with :success
    end

    it "responds with redirect when getting the edit page for a non-existing passenger" do
      # Arrange
      # Ensure there is an invalid id that points to no passenger
      # Act
      get edit_passenger_path("bad path")
      # Assert
      must_respond_with :redirect
      must_redirect_to passengers_path
    end
  end

  describe "update" do
    before do
      @passenger_hash = {
          passenger: {
              name: 'cat',
              phone_num: 'TAMLE35L3MAYRV1JD',
          }
      }
      @new_hash = {
          passenger: {
              name: 'John Smith',
              phone_num: 'TAMLE35L3MAYRV1JD',
          }
      }
      post passengers_path, params: @passenger_hash
    end

    it "can update an existing passenger with valid information accurately, and redirect" do
      passenger = Passenger.first
      expect {
        patch passenger_path(passenger.id), params: {passenger: { name: 'John Smith'} }
      }.wont_change "Passenger.count"

      passenger.reload
      expect(passenger.name).must_equal @new_hash[:passenger][:name]
      expect(passenger.phone_num).must_equal @new_hash[:passenger][:phone_num]

      must_redirect_to passenger_path(passenger.id)
    end

    it "does not update any passenger if given an invalid id, and responds with a 404" do

      patch passenger_path(656676)
      must_respond_with :not_found
    end

    it "does not edit a passenger if the form data violates Passenger validations, and responds with a redirect" do

      passenger = Passenger.first

      expect {
        patch passenger_path(passenger.id), params: {passenger: { phone_num: ''} }
      }.wont_change "passenger.phone_num"
    end
  end

  describe "destroy" do
    before do
      passenger_hash = {
          passenger: {
              name: 'cat',
              phone_num: '1B9WEX2R92R12900E',
          }
      }
      post passengers_path, params: passenger_hash
    end
    it "destroys the passenger instance in db when passenger exists, then redirects" do
      # Arrange
      # Ensure there is an existing passenger saved
      @passenger = Passenger.first
      # Act-Assert
      # Ensure that there is a change of -1 in Passenger.count
      expect {
        delete passenger_path(@passenger.id)
      }.must_change 'Passenger.count', -1
      # Assert
      # Check that the controller redirects
      must_redirect_to passengers_path
    end

    it "does not change the db when the passenger does not exist, then responds with not found" do
      # Arrange
      # Ensure there is an invalid id that points to no passenger
      # Act-Assert
      # Ensure that there is no change in Passenger.count
      expect {
        delete passenger_path(-1)
      }.wont_change 'Passenger.count'
      # Assert
      # Check that the controller responds or redirects with whatever your group decides
      must_respond_with :not_found
    end
  end
end
