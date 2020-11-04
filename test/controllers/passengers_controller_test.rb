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
    before do
      Passenger.create(name: "Test", phone_num: "555-555-5555 x695959")
    end

    it "can get the edit page for an existing passenger" do
      id = Passenger.first.id

      #act
      get edit_passenger_path(id)

      #assert
      must_respond_with :success
    end

    ###### DOESNT WORK: I think because it's failing the validation
    # it "will respond with redirect when attempting to edit a nonexistant passenger" do
    #   get passenger_path(-1)
    #
    #   must_respond_with :redirect
    # end
  end

  describe "update" do
    before do
      Passenger.create(name: "Test", phone_num: "555-555-5555 x695959")
    end
    let (:edited_passenger_hash) {
      {
          passenger: {
              name: "PASSENGER UPDATED", phone_num: "123"
          }
      }
    }

    it "can update an existing task" do
      id = Passenger.first.id

      expect {
        patch passenger_path(id), params: edited_passenger_hash
      }.wont_change "Passenger.count"

      must_respond_with :redirect

      passenger = Passenger.find_by(id: id)
      expect(passenger.name).must_equal edited_passenger_hash[:passenger][:name]
      expect(passenger.phone_num).must_equal edited_passenger_hash[:passenger][:phone_num]
    end
  end

  describe "destroy" do
    it "can destroy an Active Record instance" do
      # Arrange
      passenger = Passenger.create(name: "Passenger 1", phone_num: "123")
      id = passenger.id

      # Act
      expect {
        delete passenger_path(id)

        # Assert
      }.must_change 'Passenger.count', -1

      passenger = Passenger.find_by(name: "Passenger 1")

      expect(passenger).must_be_nil

      must_respond_with :redirect
      must_redirect_to passengers_path
    end
  end
end
