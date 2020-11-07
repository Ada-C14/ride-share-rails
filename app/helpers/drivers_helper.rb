module DriversHelper
  def driver_safe_id(driver)
    if driver
      return driver.id
    else
      return "Deleted Driver"
    end
  end

  def driver_safe_name(driver)
    if driver
      return driver.name
    else
      return "Deleted Driver"
    end
  end
end
