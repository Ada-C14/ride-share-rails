# require "test_helper"
#
describe TripsController do
  describe "show" do
    it "can get a valid trip" do
      # Act
      get "/trips"

      # Assert
      must_respond_with :success
    end

    it "will redirect for an invalid trip" do

      # Act
      get trip_path(-1)

      # Assert
      must_respond_with :redirect
    end
  end
#
 describe "create" do
    it "can create a new trip with valid information accurately, and redirect" do
      # Arrange
      # Set up the form data

      # Act-Assert
      # Ensure that there is a change of 1 in Driver.count
      expect {
        post trips_path, params: trip_hash
      }.must_change "Trip.count", 1
#
#   describe "edit" do
#     # Your tests go here
#   end
#
#   describe "update" do
#     # Your tests go here
#   end
#
#   describe "destroy" do
#     # Your tests go here
#   end
end
