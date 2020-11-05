require "test_helper"

describe PassengersController do
  let(:passenger) {
    Passenger.create name: "passenger name", phone_num: "phone number"
  }
  describe "index" do

    it "responds with success when there are many passengers saved" do
      # Arrange
      get passengers_path
      #Act
      must_respond_with :success
      # Assert
    end

  end

  describe "show" do
    # Your tests go here
    it "responds with success when showing an existing valid passenger" do #Passing
      #Arrange
      get passenger_path(passenger.id)
      # Act
      must_respond_with :success

      # Assert
    end

    it "responds with 404 with an invalid driver id" do  #Passing
      #Arrange
      get passenger_path(-10)
      # Act
      must_respond_with :not_found
      # Assert
    end
    end

  describe "new" do
    # Your tests go here
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
