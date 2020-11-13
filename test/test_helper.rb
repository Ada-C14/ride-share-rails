ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
require 'rails/test_help'
require "minitest/rails"
require "minitest/reporters"  # for Colorized output
#  For colorful output!
Minitest::Reporters.use!(
  Minitest::Reporters::SpecReporter.new,
  ENV,
  Minitest.backtrace_filter
)

class ActiveSupport::TestCase
  # Run tests in parallel with specified workers
  # parallelize(workers: :number_of_processors) # causes out of order output.

  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...
end

def create_test_driver(name: "Michael Schumacher", vin: "QWERTY99189-helper", available: true)
  driver = Driver.create(
      name: name,
      vin: vin,
      available: available
  )
  return driver
end

def create_test_passenger(name: "Mary Poppins", phone_num: "2064539189")
  passenger = Passenger.create(
      name: name,
      phone_num: phone_num
  )
  passenger.save
  return passenger
end

def create_test_trip(driver: nil, passenger: nil, cost: 123, rating: 1)
  if driver.nil?
    driver = create_test_driver()
  end

  if passenger.nil?
    passenger = create_test_passenger()
  end

  trip = Trip.create(
      driver_id: driver.id,
      passenger_id: passenger.id,
      date: "2020/11/06",
      rating: rating,
      cost: cost)
  trip.save

  return trip
end