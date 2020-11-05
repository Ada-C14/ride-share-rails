require "test_helper"

describe PassengersController do
  describe "index" do
    it "responds with success when there are many passengers saved" do
      Passenger.create(name: "CheezitMan", phone_num: "4256789098")
      # Arrange
      # Ensure that there is at least one Passenger saved
      # Act
      get passengers_path
      # Assert
      must_respond_with :success
    end

      it "responds with success when there are no passengers saved" do
        get passengers_path

        # Assert
        must_respond_with :success
      end
  end

  describe "show" do
    it "responds with success when showing an existing valid passenger" do
      passenger = Passenger.create(name: "CheezitMan", phone_num: "4258705678")
      #Act
      get passenger_path(passenger.id)
      #Assert
      must_respond_with :success

    end
    it "responds with 404 with an invalid passenger id" do
      #Act
      get passenger_path(4)
      #Assert
      must_respond_with :not_found
    end
  end

  describe "new" do
    it "responds with success" do
      #Act
      get new_passenger_path
      #Assert
      must_respond_with :success
    # Your tests go here
    end
  end

  describe "create" do
    it "can create a new passenger with valid information accurately, and redirect" do
      passenger = Passenger.create(name: "Update Me", phone_num: "345-678-7685")

      passenger_hash = {
          passenger: {
              name: "Solomon Mehru",
              phone_num: "456-879-8765"
          }
      }
      id = passenger.id
      #Assert
      expect {
        post passengers_path(id), params: passenger_hash
      }.must_change "Passenger.count", 1

      new_passenger = Passenger.find_by(name: passenger_hash[:passenger][:name])
      expect(new_passenger.name).must_equal passenger_hash[:passenger][:name]
      # expect(new_passenger.name).must_equal passenger_hash[:passenger][:name]

      must_respond_with :redirect
      must_redirect_to passenger_path(new_passenger.id)
    end
    it "does not create a passenger if the form data violates Passenger validations, and responds with a redirect" do

    end
  end
  describe "edit" do
    it "responds with success when getting the edit page for an existing, valid Passenger" do
      passenger = Passenger.create(name: "Adie A", phone_num: "123-456-7898")

      #Act
      get edit_passenger_path(passenger.id)

      #Assert
      must_respond_with :success

    end
    it "responds with redirect when getting the edit page for a non-existing passenger" do
      get edit_passenger_path(-1)
      must_respond_with :not_found
    end
  end
  describe "update" do
    it "can update an existing passenger with valid information accurately, and redirect" do
      passenger = Passenger.create(name: "Update Me", phone_num: "123-456-7898")
      passenger_hash = {
        Passenger: {
            name: "new name",
            phone_num: "123-456-7898"
        }
      }

    id = passenger.id

    expect {
      patch passenger_path(id), params: passenger_hash
    }.must_differ 'Passenger.count', 0

    must_redirect_to passenger_path(id)

    new_passenger = Passenger.find_by(id: id)
    expect(new_passenger.name).must_equal passenger_hash[:passenger][:name]
    expect(new_passenger.phone_num).must_equal passenger_hash[:passenger][:phone_num]
    end
    it "does not update any passenger if given an invalid id, and responds with a 404" do
      #Act
      patch passenger_path(-1)
      #Assert
      must_respond_with :not_found
    end
    it "does not create a passenger if the form data violates passenger validations, and responds with a redirect" do
    end
    end
    describe "destroy" do
      it "destroys the passenger instance in db when passenger exists, then redirects" do
        passenger = Passenger.create(name: "Finish Rideshare",  phone_num: "123-987-4567")
        id = passenger.id

        #act
        expect{
          delete passenger_path(id)
        }.must_change "Passenger.count", -1

        #Assert
        must_respond_with :redirect
        must_redirect_to passengers_path
      end
  end
end
