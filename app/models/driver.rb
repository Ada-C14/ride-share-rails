class Driver < ApplicationRecord
  has_many :trips

  def first_available_driver
    first_available_driver = nil
    drivers.each do |driver|
      if driver.availability == :AVAILABLE
        first_available_driver = driver
        break
      end
    end

    if first_available_driver == nil
      return "No available drivers"
    end

    def average_rating
      total = 0
      complete_trip = 0
      trips.compact.each do |trip|
        unless trip.rating.nil?
          total += trip.rating.to_f
          complete_trip += 1
        end
      end

      if complete_trip == 0
        return 0
      end

      average_total = total / complete_trip
      return average_total
    end

    def total_revenue
      revenue = 0

      trips.each do |trip|
        revenue +=
            if trip.cost.to_f > 1.65
              (trip.cost.to_f - 1.65) * 0.8
            else
              (trip.cost.to_f) * 0.8
            end
      end

      return revenue
    end
  end
