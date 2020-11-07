require "test_helper"

describe PassengersController do
  let(:passenger) {
    Passenger.create name: "passenger name", phone_num: "phone number"
  }
  describe "index" do
    it "responds with success when there are many passengers saved" do #PASSING
      # Arrange
      get passengers_path
      #Act
      must_respond_with :success
      # Assert
    end

    it "responds with success when there are no passengers saved" do
      # Arrange
      # Ensure that there are zero drivers saved
      # Act
      # Assert

    end
  end

  describe "show" do
    # Your tests go here
    it "responds with success when showing an existing valid passenger" do #Passing
      #Arrange
      get passenger_path(passenger.id)
      # Act
      must_respond_with :success

      # Assert
    end

    it "responds with 404 with an invalid driver id" do  #Passing
      #Arrange
      get passenger_path(-10)
      # Act
      must_respond_with :not_found
      # Assert
    end
  end

  describe "new" do
    it "responds with success" do
      # Your tests go here
    end
  end

  describe "create" do
    it "can create a new driver with valid information accurately, and redirect" do #PASSING
                                                                                    # Arrange
                                                                                    # Set up the form data
    new_passenger_hash = {
        passenger:{
            name: "Lip Gloss Poppin",
            phone_num: "call ( me ) beep me"
        }
    }
                                                                                    # Act-Assert # Ensure that there is a change of 1 in Driver.count
    expect {
      post passengers_path, params: new_passengers_hash
    }.must_change "Passenger.count", 1
                                                                                    # Assert
                                                                                    # Find the newly created Driver, and check that all its attributes match what was given in the form data
                                                                                    # Check that the controller redirected the user
    new_passenger = Passenger.find_by(name:new_passenger_hash[:passenger][:name])
    expect(new_passenger.phone_num).must_equal new_passenger_hash[:driver][:phone_num]
                                                                                    # expect(new_driver.available).must_equal true

    must_respond_with :redirect
    must_redirect_to passenger_path(new_passenger.id) # Your tests go here
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
