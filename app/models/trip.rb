class Trip < ApplicationRecord
  belongs_to :driver
  belongs_to :passenger
  validates :date, presence: true
  validates :cost, presence: true


  # def db_trip_cost
  #   db_trip.cost = helper.number_to_currency(@trip.cost>)
  #   return
  # end
  def assign_driver
    driver = Driver.all.select {|driver| driver.available == true }.sample
    driver.available = false
    driver.save
    return driver
  end

  def self.trip_cost
    return rand(500..10000)
  end

  # def helper
  #   @helper ||= Class.new do
  #     include ActionView::Helpers::NumberHelper
  #     end.new
  #   end
  # end

end
