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
    # Your tests go here
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
