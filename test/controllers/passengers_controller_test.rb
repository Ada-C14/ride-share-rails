require "test_helper"

describe PassengersController do
  let (:passenger) {
    Passenger.create(name: "Jane Doe", phone_number: "123-455-1234" )
  }

  describe "index" do
    it "can get the index path" do

      get passengers_path

      must_respond_with :success

    end
  end

  describe "show" do
    it "can get to the passenger details page" do

      get passenger_path(passenger.id)

      must_respond_with :success

    end

    it "will show not_found if the passenger id is not found" do
      get passenger_path(-1)

      # or should it redirect?
      must_respond_with :not_found
    end
  end

  describe "new" do
    # Your tests go here
    it "can get to the new passenger page" do

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
