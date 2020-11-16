require "test_helper"

describe PassengersController do
  before do
    Passenger.create(name: "Sample Person", phone_num: "123-456-7890")
  end
  let (:new_passenger_hash) {
    {
        passenger: {
            name: "Sample Person",
            phone_num: "123-456-7890"
        },
    }
  }
  let (:passenger) {
    Passenger.create name: "Sample Person",
                     phone_num: "123-456-7890"
  }
  # Confirm that I'm using let correctly. Can I have multiple let-blocks?
  describe "index" do
    it "can get the passengers index path" do
      get passengers_path

      must_respond_with :success
    end
  end

  describe "show" do
    it "can get a valid passenger" do
      get passenger_path(passenger.id)

      must_respond_with :success
      expect(passenger.id).must_be_instance_of Integer
      expect(passenger.name).must_be_instance_of String
      expect(passenger.phone_num).must_be_instance_of String

    end

    it "can redirect if there's an invalid passenger" do
      get passenger_path(-1)

      must_redirect_to passengers_path
    end

  end

  describe "new" do
    it "can get the new passenger page" do
      get new_passenger_path

      must_respond_with :success
    end
  end

  describe "create" do
    it "can create a new passenger" do
      passenger_hash = {
          passenger: {
              name: "New Passenger",
              phone_num: "234-523-1236"
          },
      }

      expect {
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

    it "can redirect if passenger to edit doesn't exist" do
      get edit_passenger_path(-1)

      must_respond_with :redirect
    end
  end

  describe "update" do
    it "can update an existing passenger" do
      id = Passenger.first.id

      expect {
        patch passenger_path(id), params: new_passenger_hash
      }.wont_change "Passenger.count"

      must_redirect_to passengers_path

      passenger_to_update = Passenger.find_by(id: id)
      expect(passenger_to_update.name).must_equal new_passenger_hash[:passenger][:name]
      expect(passenger_to_update.phone_num).must_equal new_passenger_hash[:passenger][:phone_num]
    end

    it "can redirect if existing passenger to update doesn't exist" do
      expect {
        patch passenger_path(-1), params: new_passenger_hash
      }.wont_change "Passenger.count"

      must_redirect_to passengers_path
    end
  end

  describe "destroy" do
    it "can destroy an existing passenger" do
      id = Passenger.first.id
      # passenger_count = Passenger.all.count

      expect {
        delete passenger_path(id)
      }.must_change "Passenger.count", -1

      deleted_passenger = Passenger.find_by(id: id)
      expect(deleted_passenger).must_be_nil

      must_respond_with :redirect
      must_redirect_to passengers_path
    end

    it "should not destroy if a passenger doesn't exist" do
      expect {
        delete passenger_path(-1)
      }.wont_change "Passenger.count"

      must_respond_with :redirect
      must_redirect_to passengers_path
    end
  end
end
