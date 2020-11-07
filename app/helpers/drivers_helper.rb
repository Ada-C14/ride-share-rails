module DriversHelper
  def driver_safe_id(driver)
    if driver
      return driver.id
    else
      return "Deleted Driver"
    end
  end
end
