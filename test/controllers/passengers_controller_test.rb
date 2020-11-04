require "test_helper"

describe PassengersController do
  describe "index" do
    # Act
    get passengers_path

    # Assert
    must_respond_with :success
  end

  describe "show" do
    passenger_id = Passenger.first.id
    get passenger_path(passenger_id)

    # Assert
    must_respond_with :success
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
