module TripsHelper
  def request_trip
    assigned_driver = @drivers.find { |driver| driver.available == true }
    if assigned_driver.nil?
      return nil
    end
    
    def random_cost
      cost = random(12...30)
      cost = cost.to_f / 100
      return cost
    end
    
end
