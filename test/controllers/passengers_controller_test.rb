require "test_helper"

describe PassengersController do
  let(:passenger) {
    Passenger.create! name: "passenger name", phone_num: "phone number"
  }


  describe "index" do
    it "responds with success when there are many passengers saved" do #PASSING
    passenger

    get passengers_path

    must_respond_with :success

    end

    it "responds with success when there are no passengers saved" do
      get passengers_path

      must_respond_with :success
    end
  end

  describe "show" do
    it "responds with success when showing an existing valid passenger" do #Passing
      get passenger_path(passenger.id)

      must_respond_with :success
    end

    it "responds with not found with an invalid driver id" do  #Passing

    get passenger_path(-1)

      must_respond_with :not_found
    end
  end

  describe "new" do
    it "responds with success" do
      # See create
    end
  end

  describe "create" do
    it "can create a new driver with valid information accurately, and redirect" do #PASSING
    new_passenger_hash = {
        passenger:{
            name: "Lip Gloss Poppin",
            phone_num: "call ( me ) beep me"
        }
    }

    expect {
      post passengers_path, params: new_passenger_hash
    }.must_change "Passenger.count", 1

    new_passenger = Passenger.find_by(name: new_passenger_hash[:passenger][:name])
    expect(new_passenger.phone_num).must_equal new_passenger_hash[:passenger][:phone_num]


    must_respond_with :redirect
    must_redirect_to passenger_path(new_passenger.id)
    end

    it "does not create a driver if the form data violates Driver validations, and responds with a redirect" do  #PASSING
    driver_hash = {
        driver: {
            name: nil,
            vin: nil,
        },
    }
                                                                                                                 # Act-Assert
    expect {
      post drivers_path, params: driver_hash
    }.wont_change "Driver.count"
                                                                                                                 # Assert
    must_respond_with :not_found
    end
  end

  describe "edit" do
    it "responds with success when getting the edit page for an existing, valid passenger" do
      get edit_passenger_path(passenger.id)

      must_respond_with :success
    end

    it "responds with redirect when getting the edit page for a non-existing passenger" do
      get edit_passenger_path(-10)

      # Act
      must_respond_with :redirect
      must_redirect_to passengers_path
    end
  end

  describe "update" do
    it "can update an existing passenger with valid information accurately, and redirect" do
      skip
      old_hash = passenger
      updated_hash = {
          passenger: {
              name: "Lip Gloss Poppin",
              phone_num: "call ( me ) beep me"
          }
      }

      expect {
        patch passenger_path(@passenger.id), params: updated_hash
      }.wont_change "Passenger.count"

      updated_passenger = Passenger.find_by(id: old_hash.id)
      expect(old_hash.name).must_equal updated_passenger[:passenger][:name]
      expect(old_hash.phone_num).must_equal updated_passenger[:passenger][:phone_num]

      must_respond_with :redirect
      must_redirect_to passenger_path(old_hash.id)
    end

    it "does not update any passenger if given an invalid id, and responds with a Not Found" do
      error_test_hash = {
          passenger: {
              name: "Testie Spice",
              phone_num: "3892789382895804"
          }
      }

      expect {
        patch passenger_path(), params: error_test_hash
      }.wont_change "Passenger.count"

      must_respond_with :not_found
    end

    it "does not create a driver if the form data violates passenger validations, and responds with a redirect" do
      skip

    end  end

  describe "destroy" do
    it "destroys the passenger instance in db when driver exists, then redirects" do
      indi_person = passenger.id

      expect {
        delete passenger_path(indi_person)
      }.must_change 'Passenger.count', -1

      must_redirect_to passengers_path
    end

    it "does not change the db when the driver does not exist, then responds with " do
      # Arrange
      # Ensure there is an invalid id that points to no driver

      # Act-Assert
      # Ensure that there is no change in Driver.count

      # Assert
      # Check that the controller responds or redirects with whatever your group decides

    end
  end
end


# Notes on let statements
# def what_let_does
#   if $global.nil?
#     $global = Passenger.create! name: "passenger name", phone_num: "phone number"
#   end
#   return $global
# end