require "test_helper"

describe PassengersController do

  describe "index" do
    it "can get the index page" do
      # Act
      get passengers_path

      # Assert
      must_respond_with :success
    end
  end

  describe "show" do
    before do
      Passenger.create(name: "Test", phone_num: "555-555-5555 x695959")
    end

    it "can get show page" do
      passenger_id = Passenger.first.id
      get passenger_path(passenger_id)

      # Assert
      must_respond_with :success
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
    it "can create a new passenger" do

      # Arrange
      passenger_hash = {
          passenger: {
              name: "Passenger2",
              phone_num: "555",
          },
      }

      # Act-Assert
      expect {
        post passengers_path, params: passenger_hash
      }.must_change "Passenger.count", 1

      new_passenger = Passenger.find_by(name: passenger_hash[:passenger][:name])
      expect(new_passenger.name).must_equal passenger_hash[:passenger][:name]
      expect(new_passenger.phone_num).must_equal passenger_hash[:passenger][:phone_num]

      must_respond_with :redirect
      must_redirect_to  passenger_path(new_passenger.id)
    end
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
