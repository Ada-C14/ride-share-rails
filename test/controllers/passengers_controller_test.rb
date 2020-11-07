require "test_helper"

describe PassengersController do
  let (:new_passenger) {
    Passenger.new(name: "Kari", phone_num: "111-111-1211")
  }
  before do
    Passenger.create(
        name: "Isis",
        phone_num: "425-555-6060",)
  end
  let (:passenger_hash) {
    {
        passenger: {
            name: "Sierra",
            description: "606-765-7878"
        }
    }
  }
  describe "index" do
    it "can get the index path" do
      # Act
      get passengers_path

      # Assert
      must_respond_with :success
    end
  end

  describe "show" do
    it "can get a valid passenger" do
      passenger = new_passenger.save
      # Act
      get passenger_path(passenger.id)

      # Assert
      must_respond_with :success
    end

    it "will redirect for an invalid trip" do
      # Act
      get passenger_path(-1)

      # Assert
      must_respond_with :redirect
    end
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

    # Act-Assert
    expect {
      post passengers_path, params: passenger_hash
    }.must_change "Passenger.count", 1

    new_passenger = Passenger.find_by(name: passenger_hash[:passenger][:name])
    expect(new_passenger.cost).must_equal trip_hash[:trip][:cost]
    expect(new_passenger.phone_num).must_equal passenger_hash[:passenger][:phone_num]

    must_respond_with :redirect
    must_redirect_to passenger_path(new_passenger.id)
  end
end

describe "edit" do
  it "can get the edit page for an existing passenger" do
    # Act
    get edit_passenger_path(passenger.id)

    # Assert
    must_respond_with :success
  end

  it "will respond with redirect when attempting to edit a nonexistant passenger" do
    # Act
    get edit_passenger_path(-1)

    # Assert
    must_respond_with :redirect
  end
end

describe "update" do
  it "can update an existing passenger" do
    passenger = Passenger.first
    expect {
      patch passenger_path(passenger.id), params: passenger_hash
    }.wont_change "Passenger.count"

    must_redirect_to root_path

    new_passenger = Passenger.find_by(name: passenger_hash[:passenger][:name])
    expect(new_passenger.cost).must_equal trip_hash[:trip][:cost]
    expect(new_passenger.phone_num).must_equal passenger_hash[:passenger][:phone_num]
  end

  it "will redirect to the root page if given an invalid id" do
    # Act
    patch passenger_path(-1)

    # Assert
    must_respond_with :redirect
  end

  describe "destroy" do
    it "can destroy an existing trip and redirect to the root page" do
      passenger = Passenger.first
      expect {
        delete passenger_path(passenger.id)
      }.must_differ 'Passenger.count', -1

      must_redirect_to root_path
    end
  end
end
