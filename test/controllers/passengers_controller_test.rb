require "test_helper"

describe PassengersController do

  before do
    @passenger = Passenger.create(name: "Passenger 1", phone_num: "1111111111")
  end
  let (:passenger) {
    Passenger.create name: "Passenger 2", phone_num: "2222222222"
  }

  describe "index" do
    it "can get the index path" do
      get passengers_path
      must_respond_with :success
    end

    it "can get the root path" do
      get root_path
      must_respond_with :success
    end
  end

  describe "show" do
    it "can get a valid passenger" do
      valid_passenger_id = @passenger.id
      get passenger_path(valid_passsenger_id)
      must_respond_with :success
    end

    it "will respond with not_found for an invalid passenger" do
      get passenger_path(-1)
      must_respond_with :not_found
    end
  end

  describe "new" do
    it "can get the new passenger page" do
      get new_task_path
      must_respond_with :success
    end
  end

  describe "create" do
    it "requires a name to create a passenger, does not create passenger otherwise, and responds with redirect if no name is entered" do
      passenger_4_hash = {
          passenger: {
              name: "",
              phone_num: "4444444444"
          }
      }
      expect{
        post passengers_path, params: passenger_4_hash
      }.wont_change "Passenger.count"

      must_respond_with :redirect
    end

    it "requires a phone number to create a passenger, does not create passenger otherwise, and responds with redirect if no phone number is entered" do
      passenger_5_hash = {
          passenger: {
              name: "Passenger 5",
              phone_num: ""
          }
      }
      expect{
        post passengers_path, params: passenger_5_hash
      }.wont_change "Passenger.count"

      must_respond_with :redirect
    end

  end

  describe "edit" do
    it "can get the edit page for an existing passenger" do
      valid_passenger_id = @passenger.id
      get edit_passenger_path(valid_passenger_id)
      must_respond_with :success
    end

    it "will respond with not_found when attempting to edit a nonexistant passenger" do
      get edit_passenger_path(-1)
      must_respond_with :not_found
    end
  end

  describe "update" do
    # Your tests go here
  end

  describe "destroy" do
    # Your tests go here
  end
end
