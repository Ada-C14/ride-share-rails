# require "test_helper"
#
# describe TripsController do
#   # Note: If any of these tests have names that conflict with either the requirements or your team's decisions, feel empowered to change the test names. For example, if a given test name says "responds with 404" but your team's decision is to respond with redirect, please change the test name.
#   let (:tpassenger) {
#     Passenger.create(name: "sample passenger", phone_num: "000-000-0000")
#   }
#
#   let (:tdriver) {
#     Driver.create(name: "sample driver", vin: "ghbgdsrklp2347bC9", available: true)
#   }
#
#   let (:trip) {
#     Trip.create date: DateTime.now, rating: 4, driver_id: tdriver.id, passenger_id: tpassenger.id, cost: 2350
#   }
#
#
#   describe "show" do
#     it "responds with success when showing an existing valid trip" do
#       # Arrange
#       # Ensure that there is a trip saved
#       trip
#
#       # Act
#       get trip_path(trip.id)
#
#       # Assert
#       must_respond_with :success
#     end
#
#     it "responds with 404 with an invalid trip id" do
#       # Arrange
#       # Ensure that there is an id that points to no trip
#       # Act
#       get trip_path(-1)
#       # Assert
#       must_respond_with :not_found
#     end
#   end
#
#   describe "create" do
#     it "can create a new trip with valid information accurately, and redirect" do
#       # Arrange
#       # Set up the form data
#       trip_hash = {
#           trip: {
#               name: "new task",
#               vin: 'ghbgdsrklp2347bC9'
#           },
#       }
#
#       # Act-Assert
#       # Ensure that there is a change of 1 in trip.count
#       expect {
#         post trips_path, params: trip_hash
#       }.must_change "Trip.count", 1
#
#       # Assert
#       # Find the newly created trip, and check that all its attributes match what was given in the form data
#       new_trip = trip.find_by(name: trip_hash[:trip][:name])
#       # Check that the controller redirected the user
#       must_respond_with :redirect
#       must_redirect_to trips_path(new_trip.id)
#       expect(new_trip.date).must_equal trip_hash[:trip][:date]
#       expect(new_trip.rating).must_equal trip_hash[:trip][:rating]
#       expect(new_trip.cost).must_equal trip_hash[:trip][:cost]
#       expect(new_trip.driver_id).must_equal trip_hash[:trip][:driver_id]
#       expect(new_trip.passenger_id).must_equal trip_hash[:trip][:passenger_id]
#     end
#
#     it "does not create a trip if the form data violates trip validations, and responds with a redirect" do
#
#       # Note: This will not pass until ActiveRecord Validations lesson
#       # Arrange
#       # Set up the form data so that it violates trip validations
#       trip_hash = {
#         trip: {
#             date: DateTime.now,
#             rating: 2,
#             cost: 2345,
#             driver_id: tdriver.id,
#             passenger_id:tpassenger.id,
#         },
#       }
#       # Act-Assert
#       # Ensure that there is no change in trip.count
#       expect {
#         post trips_path, params: trip_hash
#       }.must_differ "Trip.count", 0
#
#       # Assert
#       # Check that the controller redirects
#       must_respond_with :bad_request
#     end
#   end
#
#   describe "edit" do
#     it "responds with success when getting the edit page for an existing, valid trip" do
#
#       # Arrange
#       # Ensure there is an existing trip saved
#
#       get edit_trip_path(trip.id)
#
#       # Assert
#       must_respond_with :success
#     end
#
#     it "responds with redirect when getting the edit page for a non-existing trip" do
#       # Arrange
#       # Ensure there is an invalid id that points to no trip
#       get edit_trip_path(-1)
#
#       must_redirect_to root_path
#     end
#   end
#
#   describe "update" do
#     before do
#       Trip.create date: DateTime.now, rating: 4, driver_id: tdriver.id, passenger_id: tpassenger.id, cost: 2350
#     end
#     # tdriver
#     # tpassenger
#
#     let(:new_trip_hash) {
#       {
#           trip: {
#               date: DateTime.now,
#               rating: 2,
#               cost: 2345,
#               driver_id: tdriver.id,
#               passenger_id:tpassenger.id,
#           },
#       }
#     }
#     it "can update an existing trip with valid information accurately, and redirect" do
#       # Arrange
#       # Ensure there is an existing trip saved
#       # Assign the existing trip's id to a local variable
#       # Set up the form data
#       id = Trip.first.id
#
#       # Act-Assert
#       # Ensure that there is no change in trip.count
#       expect {
#         patch trip_path(id), params: new_trip_hash
#       }.wont_change "Trip.count"
#
#       must_respond_with :redirect
#
#       trip = trip.find_by(id: id)
#       expect(trip.date).must_equal trip_hash[:trip][:date]
#       expect(trip.rating).must_equal trip_hash[:trip][:rating]
#       expect(trip.cost).must_equal trip_hash[:trip][:cost]
#       expect(trip.driver_id).must_equal trip_hash[:trip][:driver_id]
#       expect(trip.passenger_id).must_equal trip_hash[:trip][:passenger_id]
#
#       # Assert
#       # Use the local variable of an existing trip's id to find the trip again, and check that its attributes are updated
#       # Check that the controller redirected the user
#     end
#
#     it "does not update any trip if given an invalid id, and responds with a 404" do
#       # Arrange
#       # Ensure there is an invalid id that points to no trip
#       id = -1
#       # Set up the form data
#
#
#       # Act-Assert
#       # Ensure that there is no change in trip.count
#       expect {
#         patch trip_path(id), params: new_trip_hash
#       }.wont_change "Trip.count"
#
#
#       # Assert
#       # Check that the controller gave back a 404
#       must_respond_with :not_found
#       # must_redirect_to root_path
#     end
#
#     it "does not create a trip if the form data violates trip validations, and responds with a redirect" do
#
#       # Note: This will not pass until ActiveRecord Validations lesson
#       # Arrange
#       # Ensure there is an existing trip saved
#       # Assign the existing trip's id to a local variable
#
#       # Set up the form data so that it violates trip validations
#
#       # Act-Assert
#       # Ensure that there is no change in trip.count
#
#       # Assert
#       # Check that the controller redirects
#       new_trip_hash[:trip][:rating] = nil
#       trip = trip.first
#
#       expect {
#         patch trip_path(trip.id), params: new_trip_hash
#       }.wont_change "Trip.count"
#
#       trip.reload # refresh the book from the database
#       expect(trip.rating).wont_be_nil
#       must_respond_with :redirect
#       must_redirect_to root_path
#
#     end
#   end
#
#   describe "destroy" do
#     it "destroys the trip instance in db when trip exists, then redirects" do
#       # Arrange
#       # Ensure there is an existing trip saved
#
#       # Act-Assert
#       # Ensure that there is a change of -1 in trip.count
#
#       # Assert
#       # Check that the controller redirects
#       trip_cost_to_delete = "Test cost"
#       trip_to_delete = Trip.create( date: DateTime.now, rating: 4, driver_id: tdriver.id, passenger_id: tpassenger.id, cost: trip_cost_to_delete)
#
#       # Act
#       expect {
#         delete trip_path(trip_to_delete.id)
#       }.must_change "Trip.count", -1
#
#       deleted_trip = trip.find_by(name: trip_cost_to_delete)
#       expect(deleted_trip).must_be_nil
#
#       must_respond_with :redirect
#       must_redirect_to trips_path
#     end
#
#     it "does not change the db when the trip does not exist, then responds with " do
#       # Arrange
#       # Ensure there is an invalid id that points to no trip
#
#       # Act-Assert
#       # Ensure that there is no change in trip.count
#
#       # Assert
#       # Check that the controller responds or redirects with whatever your group decides
#       expect {
#         delete trip_path(-1)
#       }.wont_change "Trip.count"
#
#       must_respond_with :not_found
#     end
#   end
# end
