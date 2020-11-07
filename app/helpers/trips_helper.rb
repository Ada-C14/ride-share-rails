require "date"
module TripsHelper
  # def available_driver
  #   assigned_driver = @drivers.find { |driver| driver.available == true }
  #   if assigned_driver.nil?
  #     return nil
  #   end
  #
  #   def random_cost
  #     cost = random(12...30)
  #     cost = cost.to_f / 100
  #     return cost
  #   end
    def assign_trip
      assigned_driver = Driver.find { |driver| driver.available == true }
      self[:driver_id] = assigned_driver.id
      self[:date] = Date.now.parse
      self[:rating] = nil
      self[:cost] = rand(12.0..30.00)
    end
end
