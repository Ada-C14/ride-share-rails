require "test_helper"

describe PassengersController do
  before do
    @passenger = Passenger.create!(name: "Test passenger", phone_num: 1232)
  end

  describe "index" do
    it "responds with success when there are many passengers saved" do
      get passengers_path

      must_respond_with :success
    end

    it "responds with success when there are no passengers saved" do
      # Ensure that there are zero passengers saved
      # Act
      expect {
        delete passenger_path(@passenger.id)
      }.must_differ 'Passenger.count', -1

      # Assert
      get passengers_path
      must_respond_with :success

    end
  end

  describe "show" do
    it "responds with success when showing an existing valid passenger" do
      # Act
      get passenger_path(@passenger.id)
      # Assert
      must_respond_with :success

    end

    it "redirects for an invalid passenger id" do
      # Arrange
      bad_id = -9999

      # Act
      get passenger_path(bad_id)

      # Assert
      must_redirect_to passengers_path
    end
  end

  describe "new" do
    it "responds with success" do
      get new_passenger_path
      must_respond_with :success
    end
  end

  describe "create" do
    it "can create a new passenger with valid information accurately, and redirect" do
      # Arrange
      passenger_hash = {
        passenger: {
          name: 'new passenger',
          phone_num: 121212
        }
      }

      expect {
        post passengers_path, params: passenger_hash
      }.must_differ 'Passenger.count', 1

      new_passenger = Passenger.find_by(name: passenger_hash[:passenger][:name])
      expect(new_passenger.name).must_equal passenger_hash[:passenger][:name]
      expect(new_passenger.phone_num).must_equal passenger_hash[:passenger][:phone_num]

      must_respond_with :redirect
      must_redirect_to passengers_path(new_passenger.id)

    end

    it "does not create a passenger if non-integer phone number" do
       # Arrange
       passenger_hash = {
        passenger: {
          phone_num: '123456',
        }
      }

      # Act-Assert
      # Ensure that there is no change in passenger.count
      expect {
        post passengers_path, params: passenger_hash
      }.wont_change 'Passenger.count'

      # Assert
      must_respond_with :success
    end

    it "does not create a passenger if missing name" do
      # Arrange
      passenger_hash = {
       passenger: {
         phone_num: 123456,
       }
     }

     # Act-Assert
     # Ensure that there is no change in passenger.count
     expect {
       post passengers_path, params: passenger_hash
     }.wont_change 'Passenger.count'

     

     # Assert
     must_respond_with :success
   end
  end
  
  describe "edit" do
    it "responds with success when getting the edit page for an existing, valid passenger" do
      get edit_passenger_path(@passenger.id)
      must_respond_with :success
    end

    it "responds with redirect when getting the edit page for a non-existing passenger" do
      get passenger_path(-1)

      must_respond_with :redirect
      must_redirect_to passengers_path
    end
  end

  describe "update" do
    let (:new_passenger_hash) {
      {
        passenger: {
          name: 'A Wrinkle in Time',
          phone_num: 22222
        }
      }
    }
    it "can update an existing passenger with valid information accurately, and redirect" do
      # Act-Assert
      # Ensure that there is no change in passenger.count
      expect {
        patch passenger_path(@passenger.id), params: new_passenger_hash # the params method set the data structure 
        }.wont_change 'Passenger.count'

      # Assert
      passenger = Passenger.find_by(id: @passenger.id)
      expect(passenger.name).must_equal new_passenger_hash[:passenger][:name]
      expect(passenger.phone_num).must_equal new_passenger_hash[:passenger][:phone_num]

      must_respond_with :redirect
      must_redirect_to passengers_path
    end

    it "does not update any passenger if given an invalid id, and responds with a redirect" do
      # Arrange
      patch passenger_path(-1)

      # Act-Assert
      # Ensure that there is no change in passenger.count
      expect {
        patch passenger_path(-1), params: new_passenger_hash # the params method set the data structure 
        }.wont_change 'Passenger.count'

      # Assert
      must_respond_with :redirect
      must_redirect_to passengers_path
    end

    it "does not update a passenger if the form data violates passenger validations, and responds with a sucess" do
       # Arrange
       passenger_hash = {
        passenger: {
          name: ""
        }
      }

      # Act-Assert
      expect {
        patch passenger_path(id: @passenger.id), params: passenger_hash
      }.wont_change 'Passenger.count'

      # Assert
      must_respond_with :success
    end
  end

  describe "destroy" do
    it "destroys the passenger instance in db when passenger exists, then redirects" do
      expect {
        delete passenger_path(@passenger.id)

      # Assert
      }.must_change 'Passenger.count', -1
    
      passenger = Passenger.find_by(name: @passenger.name)

      expect(passenger).must_be_nil

      must_respond_with :redirect
      must_redirect_to passengers_path
    end

    it "does not change the db when the passenger does not exist, then responds with redirect " do
      expect {
        delete passenger_path(-1)
      }.wont_change 'Passenger.count'

      must_respond_with :redirect
      must_redirect_to passengers_path
    end
  end
end
