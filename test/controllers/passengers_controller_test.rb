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
