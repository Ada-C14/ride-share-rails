class Driver < ApplicationRecord
  has_many :trips
  validates :name, presence: true
  validates :vin, presence: true


  def total_earnings

    if self.trips.empty?
      return 0
    else
      total_cost = trips.map do |trip|
        if trip.cost > 1.65
          (trip.cost - 1.65).to_f
        else
          return 0
        end
      end

      int_total = (total_cost.sum * 0.80)
      dollars = (int_total.to_f / 100).round(2)
      return " $#{dollars} "
    end

  end

  def avg_rating
    if self.trips.empty?
      return 0
    end
    total_rating = (trips.map {|trip| trip.rating}).sum
    return (total_rating.to_f / trips.size).round(1)
  end

  def available_driver
    self.find_by(available: true)
  end

  def toggle_status
    if self.available
      return self.update(available: false)
    else
      return self.update(available: true)
    end
  end
end

