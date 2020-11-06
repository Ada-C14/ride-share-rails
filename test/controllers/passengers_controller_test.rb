require "test_helper"

describe PassengersController do
  before do
    Passenger.create(name: "Test", phone_num: "123-123-1234")
  end

  describe "index" do
    it "should get index" do
      get "/passengers"
      must_respond_with :success
    end

  end

  describe "show" do
    before do
      @passenger = Passenger.create(name: "Test", phone_num: "123-123-1234")
    end

    it "will get show for valid ids" do
      get "/passengers/#{@passenger.id}"

      must_respond_with :success
    end

    it "will respond with not_found for invalid ids" do
      get "/passengers/-1"

      must_respond_with :not_found
    end

  end

  describe "new" do

    it "will get new_passenger_path" do
      get new_passenger_path
      must_respond_with :success
    end

    it "can get the new_passenger_trip_path" do
      Driver.create(name: "Peach", vin:"123456789", available:true )

      get new_passenger_trip_path(Passenger.first.id)
      must_respond_with :success
    end
  end

  describe "create" do
    let (:passenger_hash) {
      {
          passenger: {
              name: "Apple",
              phone_num: "123-123-1234"
          }
      }
    }

    it "can create a passenger" do
      expect {
        post passengers_path, params: passenger_hash
      }.must_differ 'Passenger.count', 1

      must_respond_with :redirect
      must_redirect_to passenger_path(Passenger.last.id)
      expect(Passenger.last.name).must_equal passenger_hash[:passenger][:name]
      expect(Passenger.last.phone_num).must_equal passenger_hash[:passenger][:phone_num]
    end

    it "will not create a passenger with invalid params" do
      passenger_hash[:passenger][:name] = nil

      expect{
        post passengers_path, params: passenger_hash
      }.wont_change "Passenger.count"

      must_respond_with :bad_request
    end

  end

  describe "edit" do
    it "will get edit_passenger_path" do
      get edit_passenger_path(Passenger.first.id)
      must_respond_with :success
    end

    it "will respond with not_found with invalid ids" do
      get edit_passenger_path(-1)
      must_respond_with :not_found
    end
  end

  describe "update" do
    let (:passenger_hash) {
      {passenger:{
          name: "Kiwi",
          phone_num: "987-987-9876"
      }}
    }

    it "will update passenger info with valid input" do
      id = Passenger.first.id
      expect {
        patch passenger_path(id), params: passenger_hash
      }.wont_change "Passenger.count"

      must_respond_with :redirect
    end

    it "will not update if the params are invalid" do
      passenger_hash[:passenger][:name] = nil
      passenger = Passenger.first

      expect {
        patch passenger_path(passenger.id), params: passenger_hash
      }.must_differ "Passenger.count", 0

      must_respond_with :bad_request

      passenger.reload
      expect(passenger.name).wont_be_nil

    end

  end

  describe "destroy" do

    it "will delete a passenger" do
      expect{
        delete passenger_path(Passenger.first.id)
      }.must_change 'Passenger.count', 1

      must_respond_with :redirect
      must_redirect_to passengers_path
    end

    it "will respond with not_found with invalid ids" do
      expect{
        delete passenger_path(-1)
      }.wont_change 'Passenger.count'

      must_respond_with :not_found
    end
  end
end
