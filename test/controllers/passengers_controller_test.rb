require "test_helper"

describe PassengersController do

  let (:passenger) {
    Passenger.create name: "Passenger",
                  phone_num: "999.999.9999"
  }

  describe "index" do
    it "can get the index path" do
      # Act
      get passengers_path

      # Assert
      must_respond_with :success
    end

    it "responds with success when there are passengers saved" do
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
    it "can get a valid passenger" do
      passenger

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
    it "can create a new passenger" do
      # Arrange
      passenger_hash = {
          passenger: {
            name: "Nina Hintz Sr.",
            phone_num: "560.815.3059"
          }
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

    it "does not create a passenger if the form data violates passenger validations" do
      # Arrange
      passenger

      invalid_params = {
          passenger: {
              name: nil,
              phone_num: "560.815.3059"
          }
      }

      expect {
        post passengers_path, params: invalid_params
      }.wont_change 'Passenger.count'
    end
  end

  describe "edit" do
    it "can get the edit page for an existing passenger" do
      # Act
      get "/passengers"

      # Assert
      must_respond_with :ok
    end

    it "will respond with redirect when attempting to edit a nonexistant passenger" do
      # Act
      get passenger_path(-1)

      # Assert
      must_respond_with :redirect
    end
  end

  describe "update" do
    it "Does not change count and redirects to passenger_path when passenger id is valid" do

      # Arrange
      Passenger.create(name: "Yvonne Okuneva IV", phone_num: "(215) 056-6568 x5330")
      passenger_hash = {
          passenger: {
          name: "Abigayle Rau Jr.",
          phone_num: "1-761-352-4516 x63527"
          },
      }
      passenger = Passenger.first

      # Act-Assert
      expect {
        patch passenger_path(passenger.id), params: passenger_hash
      }.must_differ "Passenger.count", 0

      must_redirect_to passenger_path
      expect(Passenger.last.name).must_equal passenger_hash[:passenger][:name]
      expect(Passenger.last.phone_num).must_equal passenger_hash[:passenger][:phone_num]
    end

    it "will redirect to the root page if given an invalid id" do
      # Arrange
      Passenger.create(name: "Alice Costa", phone_num: "(999) 000-9987")
      passenger_hash = {
          passenger: {
              name: "Ana Beatriz",
              phone_num: "(302) 257-9999"
          },
      }
      passenger = Passenger.first

      # Act-Assert
      expect {
        patch passenger_path(-1), params: passenger_hash
      }.must_differ "Passenger.count", 0

      must_respond_with :redirect
    end
  end

  describe "destroy" do
    it "Should delete an existing passenger and redirect to the page" do
      # Arrange
      passenger = Passenger.new name: "Ana Beatriz", phone_num:"(302) 257-9999"

      passenger.save
      passenger = passenger.id

      # Act
      expect {
        delete passenger_path(passenger)

        # Assert
      }.must_change 'Passenger.count', -1

      passenger = Passenger.find_by_id(name: "Hair Cut")

      expect(passenger).must_be_nil

      must_respond_with :redirect
      must_redirect_to passengers_path
    end

    it "will respond with not_found for invalid ids" do

      expect {
        delete passenger_path(-1)
      }.wont_change 'Passenger.count'

      must_respond_with :redirect
    end
  end
end
