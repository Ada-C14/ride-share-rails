require "test_helper"

describe PassengersController do

  let (:passenger) {
    Passenger.create(name: "Test Passenger", phone_num: "2065550000")
  }

  describe "index" do
    # Your tests go here
    it "responds with success when there are many passengers saved" do
      # Arrange
      # Ensure that there is at least one Passenger saved
      passenger
      expect(Passenger.count).must_equal 1

      # Act
      get passengers_path

      # Assert
      must_respond_with :success
    end

    it "responds with success when there are no passenger saved" do
      # Arrange
      # Ensure that there are zero passengers saved
      expect(Passenger.count).must_equal 0

      # Act
      get passengers_path

      # Assert
      must_respond_with :success
    end
  end

  describe "show" do
    # Your tests go here
    it "responds with success when showing an existing valid passenger" do
      # Arrange
      # Ensure that there is a passenger saved

      # Act
      get passenger_path(passenger.id)

      # Assert
      must_respond_with :success
    end

    it "responds with redirect with an invalid passenger id" do
      # Arrange
      # Ensure that there is an id that points to no passenger

      # Act
      get passenger_path(-1)

      # Assert
      must_respond_with :redirect
      must_redirect_to passengers_path
    end
  end

  describe "new" do
    # Your tests go here
    it "responds with success" do
      get new_passenger_path

      must_respond_with :success
    end
  end

  describe "create" do
    # Your tests go here
  end

  describe "edit" do
    # Your tests go here
  end

  describe "update" do
    # Your tests go here
  end

  describe "destroy" do
    # Your tests go here
  end
end
