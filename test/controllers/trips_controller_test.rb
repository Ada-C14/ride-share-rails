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
#   describe "create" do
#     # Your tests go here
#   end
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
