require "test_helper"

describe PassengersController do

  let (:passenger) {
    Passenger.create name: "sample passenger", phone_num: "999-999-9999"
  }
  describe "index" do
    it "can get the index path" do
      # Act
      get passengers_path

      # Assert
      must_respond_with :success
    end
  end

  describe "show" do
    it "can get a valid passenger" do

      # Act
      get passenger_path(passenger.id)

      # Assert
      must_respond_with :success
    end

    it "will redirect for an invalid passenger" do

      # Act
      get passenger_path(-1)

      # Assert
      must_respond_with :redirect
    end
  end

  describe "new" do
    it "can get the new passenger page" do

      # Act
      get new_passenger_path

      # Assert
      must_respond_with :success
    end
  end

  describe "create" do
    # Your tests go here
    it "can create a new passenger" do

      # Arrange
      passenger_hash = {
          passenger: {
              name: "Biff Jurgenstern",
              phone_num: "999-999-9999"
          }
      }

      # Act-Assert
      expect{
        post passengers_path, params: passenger_hash
      }.must_change "Passenger.count", 1

      new_passenger = Passenger.find_by(name: passenger_hash[:passenger][:name])
      expect(new_passenger.name).must_equal passenger_hash[:passenger][:name]
      expect(new_passenger.phone_num).must_equal passenger_hash[:passenger][:phone_num]

      must_respond_with :redirect
      must_redirect_to passenger_path(new_passenger.id)
    end
  end

  describe "edit" do
    it "can get the edit page for an existing passenger" do
      get edit_passenger_path(passenger.id)

      must_respond_with :success
    end

    it "will respond with redirect when attempting to edit a nonexistant passenger" do
      get edit_passenger_path(-1)

      must_respond_with :redirect
    end
  end

  describe "update" do
    before do
      Passenger.create(name: "Beef Joregnstern", phone_num: "999-999-9999")
    end

    let (:edit_passenger_hash) do
      {
          passenger: {
              name: "Will Smith",
              phone_num: "000-000-0000"
          }
      }
    end

    it "can update an existing passenger" do
      id = Passenger.first.id
      expect{
        patch passenger_path(id), params: edit_passenger_hash
      }.wont_change "Passenger.count"

      must_respond_with :redirect

      passenger = Passenger.find_by(id: id)
      expect(passenger.name).must_equal edit_passenger_hash[:passenger][:name]
      expect(passenger.phone_num).must_equal edit_passenger_hash[:passenger][:phone_num]
    end

    it "will redirect to the root page if given an invalid id" do
      # Your code here
      id = -1
      patch passenger_path(id), params: edit_passenger_hash
      must_redirect_to passengers_path
    end
  end

  describe "destroy" do
    before do
      Passenger.create(name: "Leo Trotsky", phone_num: "222-222-1312")
    end

    # Your tests go here
    it "can destroy a passenger" do
      # Arrange
      id = Passenger.first.id

      # Act
      expect{
        delete passenger_path(id)
      }.must_change 'Passenger.count', -1

      passenger = Passenger.find_by(name: "Cry in Bed")

      expect(passenger).must_be_nil

      must_respond_with :redirect
      must_redirect_to passengers_path
    end

    it "will redirect to the root page if given an invalid id" do
      # Your code here
      id = -1
      delete passenger_path(id)
      must_redirect_to passengers_path
    end
  end
end
