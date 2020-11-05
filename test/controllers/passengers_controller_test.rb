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
      get passenger_path(valid_passenger_id)
      must_respond_with :success
    end

    it "will respond with not_found for an invalid passenger" do
      get passenger_path(-1)
      must_respond_with :not_found
    end
  end

  describe "new" do
    it "can get the new passenger page" do
      get new_passenger_path
      must_respond_with :success
    end
  end

  describe "create" do
    it "requires a name to create a passenger, does not create passenger otherwise, and responds with redirect if no name is entered" do
      passenger_4_hash = {
          passenger: {
              name: nil,
              phone_num: "4444444444"
          }
      }
      expect {
        post passengers_path, params: passenger_4_hash
      }.wont_change "Passenger.count"

      must_respond_with :bad_request
    end

    it "requires a phone number to create a passenger, does not create passenger otherwise, and responds with redirect if no phone number is entered" do
      passenger_5_hash = {
          passenger: {
              name: "Passenger 5",
              phone_num: nil
          }
      }
      expect {
        post passengers_path, params: passenger_5_hash
      }.wont_change "Passenger.count"

      must_respond_with :bad_request
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

    before do
      @passenger_6_hash = {
          passenger: {
              name: "Passenger 6",
              phone_num: "6666666666"
          }
      }
    end

    it "can update an existing passenger" do
      expect {
        patch passenger_path(@passenger.id), params: @passenger_6_hash
      }.must_differ 'Passenger.count', 0

      must_redirect_to passengers_path

      updated_passenger = Passenger.find(@passenger.id)
      expect(updated_passenger.name).must_equal @passenger_6_hash[:passenger][:name]
      expect(updated_passenger.phone_num).must_equal @passenger_6_hash[:passenger][:phone_num]

    end

    it "will redirect to the root page if given an invalid id" do
      # Your code here

      expect {
        patch passenger_path(-1), params: @passenger_hash
      }.must_differ 'Passenger.count', 0

      #must_redirect_to passengers_path
      must_respond_with :not_found
    end

  end

  describe "destroy" do
    it "can destroy a model" do
      passenger7 = Passenger.new name: "Passenger 7", phone_num: "7777777777"

      passenger7.save
      id = passenger7.id

      expect {
        delete passenger_path(id)
      }.must_change 'Passenger.count', -1

      passenger7 = Passenger.find_by(name: "Passenger 7")
      expect(passenger7).must_be_nil

      #must_respond_with :not_found
      must_redirect_to passengers_path
    end

    it "will respond with not_found for invalid ids" do
      expect {
        delete passenger_path(-1)
      }.wont_change "Passenger.count"

      must_respond_with :not_found
    end

  end
end