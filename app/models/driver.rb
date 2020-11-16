class Driver < ApplicationRecord
  has_many :trips
  validates :name, presence: true
  validates :vin, length: { is: 17, message: "can't be blank"}, presence: true

  def gross_earnings
    gross_total = trips.sum(&:cost) / 100
    return gross_total
  end

  def net_earnings
    net_total = 0.8 * (gross_earnings - 1.65)
    return net_total
  end

  def average_rating
    sum_ratings = trips.sum(&:rating)
    total_trips = trips.length
    if total_trips > 0
      average = sum_ratings / total_trips
      return average
    else
      return 0
    end

  end

end
