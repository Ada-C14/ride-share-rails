require "test_helper"

describe PassengersController do
  before do
    @passenger = Passenger.new(name: "noor hoda", phone_num: "123 444 2129")
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
    end

  describe "show" do
    before do
      @passenger = Passenger.create(name: "noor hoda", phone_num: "123 444 2129")
    end

    it "can get a valid passenger" do
      get passenger_path(@passenger.id)
      must_respond_with :success
    end

    it "will respond with not_found for an invalid passenger" do
      get passenger_path(-1)
      must_respond_with :not_found
    end
  end

  describe "new" do
    it "can get the new passenger" do

      get new_passenger_path
      must_respond_with :success
    end
  end

  describe "create" do
    it "can create a new passenger" do
    # Arrange
    passenger_hash = {
        passenger: {
            name: "noor hoda",
            phone_num: "565 888 9997"
        },
    }
    # Act-Assert
    expect {
      post passengers_path, params: passenger_hash
    }.must_change "Passenger.count", 1

    new_passenger = Passenger.find_by(name: passenger_hash[:passenger][:name])
    expect(new_passenger.phone_num).must_equal passenger_hash[:passenger][:phone_num]

    must_respond_with :redirect
    must_redirect_to passenger_path(new_passenger.id)
  end
    end

  describe "edit" do
    before do
      @passenger = Passenger.create(name: "noor hoda", phone_num: "123 444 2129")
    end

    it "can get the edit page for an existing passenger" do
      get edit_passenger_path(@passenger.id)
      must_respond_with :success
    end

    it "will respond with not_found when attempting to edit a nonexistant passenger" do
      get edit_passenger_path(-1)
      must_respond_with :not_found
    end
  end

  describe "update" do
    before do
      @passenger = Passenger.create(name: "noor hoda", phone_num: "123 444 2129")
    end

    it "can update an existing passenger" do
      #arrange
      updated_passenger_hash = {
          passenger: {
              name: "noor hoda",
              phone_num: "565 888 9997"
          },
      }
      passenger = Passenger.first

      #act
      expect {
        patch passenger_path(passenger.id), params: updated_passenger_hash
      }.wont_change "Passenger.count"

      #assert
      must_redirect_to passenger_path

      passenger = Passenger.find_by(id: passenger.id)
      expect(passenger.name).must_equal updated_passenger_hash[:passenger][:name]
    end

    it "will respond with not found if given an invalid id" do
      updated_passenger_hash = {
          passenger: {
              name: "noor hoda",
              phone_num: "565 888 9997"
          },
      }
      expect {
        patch passenger_path(-1), params: updated_passenger_hash
      }.wont_change "Passenger.count"

      must_respond_with :not_found
    end
  end

  describe "destroy" do
    it "can destroy a model and redirect to the index page" do
      #arrange

      passenger_to_delete = Passenger.new(name: "Noor Hoda")
      passenger_to_delete.save
      id = passenger_to_delete.id

      #act
      expect {
        delete passenger_path(id)
        #assert
      }.must_change 'Passenger.count', -1

      passenger_to_delete = Passenger.find_by(name: "Noor Hoda")
      expect(passenger_to_delete).must_be_nil

      must_respond_with :redirect
      must_redirect_to passengers_path
    end

    it "will respond with not_found for non-existing id" do
      expect {
        delete passenger_path(-1)
      }.wont_change "Passenger.count"

      must_respond_with :not_found
    end
  end
  end


