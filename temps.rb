# create method in trips
# passenger/:passenger_id/trip - will be route for create
def create
  driver = Driver.find_by(:available = true)
  passenger = Passenger.find_by(id: params[:passenger_id])
  @trip = Trip.create(
    driver_id: driver.id,
    passenger_id: passenger.id,
    date: Time.now,
    rating: nil,
    cost: 123232
  )
end

# in the routes
resources :passengers do
  resources :trips, only [:create]

  post passenger/:passenger_id/trip, to trips#create, as: passenger_trips

# can set driver as unavilable in trips#create too 
# user action to set driver as unavailable 
# patch driver/:id/set_unavailable to: driver#unavailable, as: set_unavailable
# driver_controller
def set_unavailable
  # maybe a find by here? idk girl. if driver.nil? redirect, else mark unavailable
  driver.mark_unavailable
end


