class Trip < ApplicationRecord
  belongs_to :driver
  belongs_to :passenger

  def cost_to_string
    cost = self.cost.to_f / 100
    cost = '%.2f' % cost
    return " $#{cost} "
  end

  def passenger_name
    if self.passenger.name != nil
      return self.passenger.name
    else
      self.passenger.name = "DELETED PASSENGER"
      return self.passenger.name
    end
  end

  def driver_name
    if self.driver.name != nil
      self.driver.name
      return
    else
      self.driver.name = "DELETED PASSENGER"
      self.driver.name
      return
    end
  end

end
