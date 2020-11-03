require "test_helper"

describe PassengersController do
  let(:passenger) do
    Passenger.create name: 'Ayesha', phone_num: '425.786.3603'
  end
  describe "index" do
    it "responds with success when there are many passengers saved" do
      get passengers_path

      # Assert
      must_respond_with :success

    end

    it "responds with success when there are no passengers saved" do
      get passengers_path

      must_respond_with :success

    end
  end

  describe "show" do
    it "responds with success when showing an existing valid passenger" do
      get passenger_path(passenger.id)

      must_respond_with :success
    end

    it "responds with 404 with an invalid passenger id" do
      get passenger_path(-1)

      # Assert
      must_respond_with :not_found

    end
  end

  describe "new" do
    it "responds with success" do
      get new_passenger_path

      # Assert
      must_respond_with :success
    end
  end

  describe "create" do
    it "can create a new passenger with valid information accurately, and redirect" do
      passenger_params = {
        passenger: {
          name: 'Ayesha',
          phone_num: '425.786.3603'
        }
      }
      expect do
        post passengers_path, params: passenger_params
      end.must_change 'Passenger.count', 1

      new_passenger = Passenger.find_by(name: passenger_params[:passenger][:name])
      expect(new_passenger.phone_num).must_equal passenger_params[:passenger][:phone_num]

      must_respond_with :redirect
      must_redirect_to passenger_path(new_passenger.id)
    end

    it 'will redirect to the passenger_path' do
      passenger_params = {
        passenger: {
          name: 'Ayesha',
          phone_num: '425.786.3603'
        }
      }

      post passengers_path, params: passenger_params

      new_passenger = Passenger.find_by(name: passenger_params[:passenger][:name])

      must_redirect_to passenger_path(new_passenger.id)
    end

    it 'will add a new passenger to the database' do
      passenger_params = {
        passenger: {
          name: 'Ayesha',
          phone_num: '425.786.3603'
        }
      }

      expect {
        post passengers_path, params: passenger_params
      }.must_change "Passenger.count", 1
    end

    it "does not create a passenger if the form data violates Passenger validations, and responds with a redirect" do
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
    it "responds with success when getting the edit page for an existing, valid passenger" do
      get edit_passenger_path(passenger.id)

      must_respond_with :success
    end

    it "responds with redirect when getting the edit page for a non-existing passenger" do
      get edit_passenger_path(-1)

      must_respond_with :redirect
    end
  end

  describe "update" do
    before do
      Passenger.create(name: 'Roshni', phone_num: '123.456.7890')
    end
    let(:new_passenger_hash) do
      {
        passenger: {
          name: 'Ayesha',
          phone_num: '123.456.7890'
        }
      }
    end
    it "can update an existing passenger with valid information accurately, and redirect" do
      id = Passenger.first.id
      expect do
        patch passenger_path(id), params: new_passenger_hash
      end.wont_change 'Passenger.count'

      must_redirect_to passenger_path(id)

      passenger = Passenger.find_by(id: id)
      expect(passenger.name).must_equal new_passenger_hash[:passenger][:name]
      expect(passenger.phone_num).must_equal new_passenger_hash[:passenger][:phone_num]

    end

    it "does not update any passenger if given an invalid id, and responds with a 404" do
      id = -1

      expect do
        patch passenger_path(id), params: new_passenger_hash
      end.wont_change 'Passenger.count'

      must_respond_with :not_found
    end

    it "does not create a passenger if the form data violates Driver validations, and responds with a redirect" do
      # Note: This will not pass until ActiveRecord Validations lesson
      # Arrange
      # Ensure there is an existing driver saved
      # Assign the existing driver's id to a local variable
      # Set up the form data so that it violates Driver validations

      # Act-Assert
      # Ensure that there is no change in Driver.count

      # Assert
      # Check that the controller redirects

    end
  end

  describe "destroy" do
    it "destroys the passenger instance in db when passenger exists, then redirects to root_path" do
      new_passenger = Passenger.create(name: 'Roshni', phone_num: '123.456.7890')

      new_passenger.save

      id = new_passenger.id

      # Act
      expect do
        delete passenger_path(id)

        # Assert
      end.must_change 'Passenger.count', -1

      must_respond_with :redirect
      must_redirect_to root_path
    end

    it "does not change the db when the driver does not exist, then responds with 404 " do
      id = -1

      expect do
        delete passenger_path(id)
      end.wont_change 'Passenger.count'

      must_respond_with :not_found
    end
  end
end
