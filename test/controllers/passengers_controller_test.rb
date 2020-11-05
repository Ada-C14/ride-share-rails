require "test_helper"

describe PassengersController do

  let (:passenger) {
    Passenger.create name: 'Schanen Ryan', phone_num: '888-888-8888'
  }
  describe "index" do

    it "can get the index path" do
      # Act
      get passengers_path
      # Assert
      must_respond_with :success
    end

    it "can get the root path" do
      # Act
      get root_path

      # Assert
      must_respond_with :success
    end

    it "responds with success when there are many passengers saved" do
      # Arrange
      # Ensure that there is at least one Driver saved
      passengers_arr_hsh =  [
          {name: 'Fence Person', phone_num: '(827)947-2746'},
          {name: 'Jello Porcini', phone_num: '+1 3467 56789'},
          {name: 'Donald Duck', phone_num: '411'}
      ]


      # Act-Assert
      passengers_arr_hsh.each do |passenger|
        expect{
          post passengers_path, params: { passenger: {name: passenger[:name], phone_num: passenger[:phone_num] } }
        }.must_change "Passenger.count", 1
      end
    end

    # it "responds with success when there are no drivers saved" do
    #   # Arrange
    #   # Ensure that there are zero drivers saved
    #   # when seeing index page with no drivers, no errors, can be re-direct to homepage
    #
    #   # Act
    #
    #   # Assert
    #
    # end
  end

  describe "show" do
    it "responds with success when showing an existing valid passenger" do
      # Arrange
      # Ensure that there is a driver saved
      # Act
      get passenger_path(passenger.id)
      # Assert
      must_respond_with :success

    end

    it "responds with a redirect for an invalid passenger" do
      # Arrange
      # Ensure that there is an id that points to no driver

      # Act
      get passenger_path(-1)

      # Assert
      must_respond_with :redirect

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
    it "can create a new passenger" do

      # Arrange
      passenger_hash = {
          passenger: {
              name: 'Donald Duck',
              phone_num: '411'
          }
      }

      # Act-Assert
      expect {
        post passengers_path, params: passenger_hash
      }.must_change "Passenger.count", 1

      new_passenger = Passenger.find_by(name: passenger_hash[:passenger][:name])
      expect(new_passenger.name).must_equal passenger_hash[:passenger][:name]
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

      #Act
      get edit_passenger_path(-1)

      #Assert
      must_respond_with :redirect

    end
  end

  describe "update" do

    before do
      @passenger_hash = {
          passenger: {
              name: "Jello Porcini",
              phone_num: '12345',
          },
      }

      @updating_hash = {
          passenger: {
              name: "updated passenger name",
              phone_num: '54321'
          }
      }

    end

    it "can update an existing passenger" do
      # Arrange

      post passengers_path, params: @passenger_hash

      p Passenger.first
      puts "**************************************************************"

      original_passenger = Passenger.find_by(name: @passenger_hash[:passenger][:name])
      passenger_id = original_passenger.id

      # Act-Assert
      expect{
        patch passenger_path(passenger_id), params: @updating_hash
      }.wont_change "Passenger.count"

      expect(original_passenger.name).must_equal @updating_hash[:passenger][:name]

      must_redirect_to passenger_path(Passenger.first.id)
    end

    it "will redirect to the root page if given an invalid id" do
      # Arrange
      patch passenger_path(-1)

      #Act-Assert
      must_respond_with :redirect
      must_redirect_to passengers_path
    end
  end

  describe "destroy" do
    it "can destroy a model" do
      # Arrange
      passenger_to_delete = Passenger.new name: "passenger to delete", phone_num: '911'

      passenger_to_delete.save
      id = passenger_to_delete.id

      # Act
      expect {
        delete passenger_path(id)
        # Assert
      }.must_change 'Passenger.count', -1

      deleted_passenger = Passenger.find_by(name: "passenger to delete")

      expect(deleted_passenger).must_be_nil

      must_respond_with :redirect
      must_redirect_to passengers_path
    end
  end
end
