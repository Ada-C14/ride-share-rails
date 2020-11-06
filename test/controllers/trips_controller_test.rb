require "test_helper"

describe TripsController do
  let (:driver) {
    Driver.create(name: "Test Driver", vin: "12345678912345678", available: true)
  }

  let (:passenger) {
    Passenger.create(name: "Test Passenger", phone_num: "206-555-5555")
  }

  let (:trip) {
    Trip.create(date: "2020-11-05",
                rating: nil,
                cost: 1000,
                passenger: passenger,
                driver: driver)
  }

  describe "show" do
    # Your tests go here
    it "responds with success when showing an existing valid trip" do
      get trip_path(trip.id)

      must_respond_with :success
    end

    it "responds with redirect with an invalid trip id" do
      get trip_path(-1)

      must_respond_with :redirect
      must_redirect_to root_path
    end

  end

  describe "create" do
    # Your tests go here
    # refactor!
    it "can create a new trip with valid information and redirect" do
    task_hash = {
        task: {
            name: "new task",
            description: "new task description",
            completed_at: nil,
        },
    }

    # Act-Assert
    expect {
      post tasks_path, params: task_hash
    }.must_change "Task.count", 1

    new_task = Task.find_by(name: task_hash[:task][:name])
    expect(new_task.description).must_equal task_hash[:task][:description]
    expect(new_task.completed_at).must_equal task_hash[:task][:completed_at]

    must_respond_with :redirect
    must_redirect_to task_path(new_task.id)
    end

    it "won't create an invalid trip if no drivers available and will redirect with a bad request" do

    end


  end

  describe "edit" do
    # Your tests go here
    # refactor!
    it "can get the edit page for an existing task" do
      # skip
      get edit_task_path(task.id)

      # Assert
      must_respond_with :success
    end

    it "will respond with redirect when attempting to edit a nonexistant task" do
      #skip
      # Act
      get task_path(-1)

      # Assert
      must_respond_with :redirect
    end
  end

  describe "update" do
    # Your tests go here
  end

  describe "destroy" do
    # Your tests go here
  end
end
