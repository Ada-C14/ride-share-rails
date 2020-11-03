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
    it "can get to the passenger details page" do

      get passenger_path(passenger.id)

      must_respond_with :success

    end

    it "will show not_found if the passenger id is not found" do
      get passenger_path(-1)

      # or should it redirect?
      must_respond_with :not_found
    end
  end

  describe "new" do
    # Your tests go here
    it "can get to the new passenger page" do

      get new_passenger_path

      must_respond_with :success
    end
  end

  describe "create" do
    # Your tests go here
    it "can create a new passenger" do
      passenger_hash = {
          passenger: {
              name: "Tram Bui",
              phone_num: "000-111-2222"
          }
      }

      expect {
        post passengers_path, params: passenger_hash
      }.must_differ "Passenger.count", 1

      # new_passenger = Passenger.find_by
      expect(Passenger.last.name).must_equal passenger_hash[:passenger][:name]
      expect(Passenger.last.phone_num).must_equal passenger_hash[:passenger][:phone_num]


      must_respond_with :redirect
      must_redirect_to passengers_path

    end

    # to be filled in
    # it "will not create a passenger with invalid params" do
    #
    # end

  end

  describe "edit" do
    it "can get the edit page for an existing passenger" do
      get edit_passenger_path(passenger.id)

      must_respond_with :success

    end

    it "will show not_found when trying to edit invalid passenger" do

      get edit_passenger_path(-1)

      must_respond_with :not_found
    end
  end

  describe "update" do

    before do
      Passenger.create(name: "Testing passenger",
                       phone_num: "000-111-4567"
      )
    end

    let (:new_passenger_hash) {
      {
          passenger: {
              name: "again testing name",
              phone_num: "000-111-4567"
          },
      }
    }

    it "can update an existing passenger" do

      id = Passenger.first.id
      expect {
        patch passenger_path(id), params: new_passenger_hash
      }.wont_differ "Passenger.count"

      must_redirect_to passengers_path

      passenger = Passenger.find_by(id: id)
      expect(passenger.name).must_equal new_passenger_hash[:passenger][:name]
      expect(passenger.phone_num).must_equal new_passenger_hash[:passenger][:phone_num]

      
    end

    it "will show not_found if given invalid id" do
      id = -1
      expect {
        patch passenger_path(id), params: new_passenger_hash
      }.wont_differ "Passenger.count"

      must_respond_with :not_found
    end
  end

  describe "destroy" do
    # Your tests go here
  end
end
