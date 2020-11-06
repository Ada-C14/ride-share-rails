require "test_helper"

describe PassengersController do
  before do
    @passenger = Passenger.new(name: "hello world", phone_num: "123 444 2129")
  end
  describe "index" do
    it "can get the index path" do

      get passengers_path #resources :passengers
      must_respond_with :success
    end
    it "can get the root path" do

      get root_path
      must_respond_with :success
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
  end
