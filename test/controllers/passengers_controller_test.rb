require "test_helper"

describe PassengersController do
  describe "index" do
    it "responds with success when there are many passengers saved" do
      # Assert
      @passenger1 = Passenger.create(name: "Kim Vitug", phone_num: "555-555-5555")
      @passenger2 = Passenger.create(name: "Sophie Messing", phone_num: "777-777-7777")
      @passenger3 = Passenger.create(name: "Valentine Messing", phone_num: "888-888-8888")

      # Act
      get passengers_path

      # Assert
      must_respond_with :success
    end

    it "responds with success when there are no passengers saved" do

      # Act
      get passengers_path

      # Assert
      must_respond_with :success
    end
  end

  describe "show" do
    before do
      @passenger1 = Passenger.create(name: "Kim Vitug", phone_num: "555-555-5555")
      @passenger2 = Passenger.create(name: "Sophie Messing", phone_num: "777-777-7777")
      @passenger3 = Passenger.create(name: "Valentine Messing", phone_num: "888-888-8888")
    end

    it "responds with success when showing an existing valid passenger" do
      # Act
      get passenger_path(@passenger1.id)

      # Assert
      must_respond_with :success
    end

    it "responds with 404 with an invalid passenger id" do
      # Act
      get passenger_path(-1)

      # Assert
      must_respond_with :not_found
    end
  end

  describe "new" do
    it "responds with success" do
      # Act
      get new_passenger_path

      # Assert
      must_respond_with :success
    end
  end

  describe "create" do
    it "can create a new passenger with valid information accurately, and redirect" do
      # Arrange
      passenger_hash = {
          passenger: {
              name: "New Passenger",
              phone_num: "444-444-4444"
          },
      }
      # Act-Assert
      expect{
        post passengers_path, params: passenger_hash
      }.must_change "Passenger.count", 1

      new_passenger = Passenger.find_by(name: passenger_hash[:passenger][:name])

      expect(new_passenger.phone_num).must_equal passenger_hash[:passenger][:phone_num]

      must_respond_with :redirect
      must_redirect_to passenger_path(new_passenger.id)
    end

    #TODO form validation tests?
    it "does not create a passenger if the form data violates Passenger validations, and responds with a redirect" do
      skip
      # Note: This will not pass until ActiveRecord Validations lesson
      # Arrange
      # Set up the form data so that it violates Driver validations

      # Act-Assert
      # Ensure that there is no change in Driver.count

      # Assert
      # Check that the controller redirects

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
