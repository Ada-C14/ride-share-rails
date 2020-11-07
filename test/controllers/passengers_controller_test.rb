require "test_helper"

describe PassengersController do

  before do
    @passenger = Passenger.create name: 'Test Passenger', phone_num: '293-293-2938'
  end

  describe "index" do
    it "responds with success when there are many passengers saved" do
      # Act
      get passengers_path

      # Assert
      must_respond_with :success

    end

    it "responds with success when there are no passengers saved" do
      #Arrange
      @passenger.destroy

      # Act
      get passengers_path

      # Assert
      must_respond_with :success

    end

  end

  describe "show" do
    it "responds with success when showing an existing valid oassenger" do

      # Act
      get passenger_path(@passenger.id)

      # Assert
      must_respond_with :success

    end

    it "responds with 404 with an invalid passenger id" do

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
